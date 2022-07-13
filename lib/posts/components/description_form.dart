import 'package:flutter/material.dart';
import 'package:kosmos_app/myColors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

FirebaseFirestore firestore = FirebaseFirestore.instance;
final _formKey = GlobalKey<FormState>();

class DescriptionForm extends StatelessWidget {
  final value_ID;

  // ignore: non_constant_identifier_names
  DescriptionForm({Key? key, this.value_ID}) : super(key: key);
  final descriptionField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 400,
                decoration: BoxDecoration(color: AppColors.inputBackground),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'remplir le formulaire';
                        }
                        return null;
                      },
                      controller: descriptionField,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Décrivez votre post..',
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.inputText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Création du post')),
                      );
                      addPost(descriptionField.text.trim(), value_ID, context);

                      // Navigator.pushNamed(context, '/home');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: const Text(
                    'Suivant',
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Future addPost(String description, valueID, context) {
  return firestore
      .collection('Posts')
      .doc(valueID.toString())
      .update({'description': description}).then((value) {
    Navigator.pushNamed(context, '/home');
  }).catchError(
    (error) => print("Erreur: $error"),
  );
}
