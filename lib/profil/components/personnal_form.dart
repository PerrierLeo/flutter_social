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

class PersonnalForm extends StatefulWidget {
  const PersonnalForm({super.key});

  @override
  PersonnalFormState createState() {
    return PersonnalFormState();
  }
}

class PersonnalFormState extends State<PersonnalForm> {
  final _formKey = GlobalKey<FormState>();
  final FirstnameField = TextEditingController();
  final LastnameField = TextEditingController();
  bool FirstnameFieldIsEmpty = true;
  bool LastnameFieldIsEmpty = true;

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
                'Prénom*',
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
                  controller: FirstnameField,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'remplir le champ prénom';
                    }
                    return null;
                  },
                  onChanged: (String text) {
                    setState(
                      () {
                        FirstnameFieldIsEmpty = false;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Prénom*',
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
                'Nom*',
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
                  controller: LastnameField,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'remplir le champ nom';
                    }
                    return null;
                  },
                  onChanged: (String text) {
                    setState(
                      () {
                        LastnameFieldIsEmpty = false;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Nom*',
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
                        const SnackBar(content: Text('Validation des données')),
                      );
                      subscribeToFirebase(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _getContainerBackgroundColor(),
                  ),
                  child: const Text(
                    'Enregistrer',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '* Les champs marqués sont obligatoires ',
                    style: GoogleFonts.poppins(color: AppColors.inputText),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Color _getContainerBackgroundColor() {
    if (FirstnameFieldIsEmpty || LastnameFieldIsEmpty) {
      return AppColors.informationText;
    } else {
      return Colors.black;
    }
  }

  void subscribeToFirebase(context) {
    try {
      addUser(
        currentUser!.uid,
        FirstnameField.text.trim(),
        LastnameField.text.trim(),
      ).then(
        (value) {
          print(currentUser!.uid);
          FirstnameField.clear();
          LastnameField.clear();
        },
      );
    } catch (error) {
      print(error.toString());
    }
  }
}

Future<void> addUser(String userID, String firstname, String lastname) {
  return firestore.collection('Users').doc(userID).set({
    'firstname': firstname,
    'lastname': lastname,
  }).then((value) {
    print("Utilisateur ajouté");
  }).catchError(
    (error) => print("Erreur: $error"),
  );
}
