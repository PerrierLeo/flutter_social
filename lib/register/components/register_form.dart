import 'package:flutter/material.dart';
import 'package:kosmos_app/myColors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kosmos_app/register/components/checkbox.dart';
import 'package:kosmos_app/register/create_profil_page.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;
final storage = FirebaseStorage.instance;
final ScrollController _firstController = ScrollController();

// Create a Form widget.
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final EmailField = TextEditingController();
  final PasswordField = TextEditingController();
  final ConfirmPasswordField = TextEditingController();

  bool EmailFieldIsEmpty = true;
  bool PasswordFieldIsEmpty = true;
  bool ConfirmPasswordFieldIsEmpty = true;

  bool PasswordFieldHide = true;
  bool ConfirmPasswordFieldHide = true;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Adresse email',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TextFormField(
                  controller: EmailField,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'remplir le champ email';
                    }
                    return null;
                  },
                  onChanged: (String text) {
                    setState(
                      () {
                        EmailFieldIsEmpty = false;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'john.doe@gmail.com',
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.inputText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Mot de passe',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TextFormField(
                  obscureText: PasswordFieldHide,
                  controller: PasswordField,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'remplir le champ mot de passe';
                    }
                    return null;
                  },
                  onChanged: (String text) {
                    setState(
                      () {
                        PasswordFieldIsEmpty = false;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Mot de passe',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            PasswordFieldHide = !PasswordFieldHide;
                          },
                        );
                      },
                      icon: const Icon(Icons.remove_red_eye_sharp),
                    ),
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.inputText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Confirmez mot de passe*',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TextFormField(
                  obscureText: ConfirmPasswordFieldHide,
                  controller: ConfirmPasswordField,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'remplir le champ mot de passe';
                    } else if (value != PasswordField.text.trim()) {
                      return 'les mots de passe ne correspondent pas';
                    }
                    return null;
                  },
                  onChanged: (String text) {
                    setState(
                      () {
                        ConfirmPasswordFieldIsEmpty = false;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Confirmez mot de passe',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            ConfirmPasswordFieldHide =
                                !ConfirmPasswordFieldHide;
                          },
                        );
                      },
                      icon: const Icon(Icons.remove_red_eye_sharp),
                    ),
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.inputText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      subscribeToFirebase(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: const Text(
                    'Terminer l\'inscription',
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _showCGVUModal(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return Wrap(
          children: [
            Container(
              color: Colors.transparent,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55.0),
                    topRight: Radius.circular(55.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(2),
                      color: const Color.fromRGBO(219, 219, 219, 1),
                      width: 57,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Color(0xfff8f8f8),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'CGVU et politique de',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'confidentialité',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 430,
                            child: Scrollbar(
                              controller: _firstController,
                              thumbVisibility: true,
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: ListView(
                                  children: [
                                    Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam facilisis ex ex, nec pretium ante mollis id. Nullam lorem magna, malesuada sit amet nisi ut, congue lobortis turpis. Nulla pellentesque libero vitae mollis facilisis. Nulla auctor diam posuere aliquam scelerisque. Curabitur id sodales diam. Aliquam ut bibendum mi. Proin id ipsum sed nisl commodo dapibus. Aliquam eleifend mollis ipsum, vel rhoncus mauris. In a neque a urna vulputate elementum non sed quam. Ut in faucibus ante.',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromRGBO(
                                            167, 173, 181, 1),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam facilisis ex ex, nec pretium ante mollis id. Nullam lorem magna, malesuada sit amet nisi ut, congue lobortis turpis. Nulla pellentesque libero vitae mollis facilisis. Nulla auctor diam posuere aliquam scelerisque. Curabitur id sodales diam. Aliquam ut bibendum mi. Proin id ipsum sed nisl commodo dapibus. Aliquam eleifend mollis ipsum, vel rhoncus mauris. In a neque a urna vulputate elementum non sed quam. Ut in faucibus ante.',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromRGBO(
                                            167, 173, 181, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const checkBox(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "J’accepte la politique de confidentialité et les",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(2, 19, 43, 1),
                                    ),
                                  ),
                                  Text(
                                    "conditions générales de ventes et d’utilisation.",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(2, 19, 43, 1),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 54,
                            width: 169,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                sendEmailVerification(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                              ),
                              child: Text(
                                'Continuer',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  _showMailReception(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 310, maxWidth: 282),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Color.fromRGBO(146, 153, 164, 1),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Vérifiez votre boîte',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
                Text(
                  'mail',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Un email de vérification vous a",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(167, 173, 181, 1),
                  ),
                ),
                Text(
                  "été envoyé à l’adresse",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(167, 173, 181, 1),
                  ),
                ),
                Text(
                  currentUser!.email!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(167, 173, 181, 1),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 139,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateProfilPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: const Text(
                      'Fermer',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  sendEmailVerification(context) {
    Navigator.pop(context);
    _showMailReception(context);
    currentUser?.sendEmailVerification();
  }

  Future<void> subscribeToFirebase(context) async {
    print(EmailField.text.trim());
    print(PasswordField.text.trim());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: EmailField.text.trim(),
        password: PasswordField.text.trim(),
      );
      _showCGVUModal(context);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${e.message}"),
        ),
      );
    }
  }
}
