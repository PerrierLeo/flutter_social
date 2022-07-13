import 'package:flutter/material.dart';
import 'package:kosmos_app/myColors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;
final storage = FirebaseStorage.instance;

// Create a Form widget.
class PasswordForm extends StatefulWidget {
  const PasswordForm({super.key});

  @override
  PasswordFormState createState() {
    return PasswordFormState();
  }
}

class PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final PasswordField = TextEditingController();
  final NewPasswordField = TextEditingController();
  final ConfirmPasswordField = TextEditingController();

  bool PasswordFieldIsEmpty = true;
  bool NewPasswordFieldIsEmpty = true;
  bool ConfirmPasswordFieldIsEmpty = true;

  bool PasswordFieldHide = true;
  bool NewPasswordFieldHide = true;
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
                'Mot de passe actuel*',
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
                    hintText: 'Mot de passe actuel',
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
                'Nouveau mot de passe*',
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
                  obscureText: NewPasswordFieldHide,
                  controller: NewPasswordField,
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
                        NewPasswordFieldIsEmpty = false;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Nouveau mot de passe',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            NewPasswordFieldHide = !NewPasswordFieldHide;
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
                'Confirmez nouveau mot de passe*',
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
                    } else if (value != NewPasswordField.text.trim()) {
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
                    hintText: 'Confirmez nouveau mot de passe',
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      subscribeToFirebase(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: const Text(
                    'Modifier',
                  ),
                ),
              ),
            ],
          ),
        )
      ],
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
                      Navigator.pushNamed(context, '/home');
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

  Future<void> subscribeToFirebase(context) async {
    try {
      await currentUser?.updatePassword(ConfirmPasswordField.text.trim()).then(
        (value) {
          print(currentUser!.email);
          NewPasswordField.clear();
          PasswordField.clear();
          NewPasswordField.clear();
          ConfirmPasswordField.clear();

          _showMailReception(context);
        },
      );
    } catch (error) {
      print(error.toString());
    }
  }
}
