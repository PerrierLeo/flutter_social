import 'package:flutter/material.dart';
import 'package:kosmos_app/myColors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'reinitialize_button.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;
final storage = FirebaseStorage.instance;

// Create a Form widget.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final EmailField = TextEditingController();
  final PasswordField = TextEditingController();

  bool EmailFieldIsEmpty = true;
  bool PasswordFieldIsEmpty = true;

  bool PasswordFieldHide = true;

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
                    hintText: 'Nouveau mot de passe',
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
              ReinitializeButton(),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loginToFirebase();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: const Text(
                    'Connexion',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pas de compte ?',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.inputText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Créer maintenant',
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  loginToFirebase() {
    print(EmailField.text.trim());
    print(PasswordField.text.trim());
    try {
      auth
          .signInWithEmailAndPassword(
              email: EmailField.text.trim(),
              password: PasswordField.text.trim())
          .then(
        (value) {
          print(value.user?.email.toString());
          Navigator.pushNamed(context, '/home');
        },
      );
    } catch (error) {
      print(error.toString());
    }
  }
}
