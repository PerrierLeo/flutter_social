import 'package:flutter/material.dart';
import 'package:kosmos_app/myColors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;
final storage = FirebaseStorage.instance;

// Create a Form widget.
class ProfilForm extends StatefulWidget {
  const ProfilForm({super.key});

  @override
  ProfilFormState createState() {
    return ProfilFormState();
  }
}

class ProfilFormState extends State<ProfilForm> {
  final _formKey = GlobalKey<FormState>();
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
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
                  // The validator receives the text that the user has entered.
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
              const SizedBox(height: 10),
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
                  // The validator receives the text that the user has entered.
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
                'Photo de profil*',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  selectFile();
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  height: 108,
                  decoration: BoxDecoration(
                    color: AppColors.inputBackground,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (pickedFile != null)
                          Text(
                            pickedFile!.name,
                            style:
                                GoogleFonts.poppins(color: AppColors.inputText),
                          ),
                        Icon(Icons.cloud_upload_outlined,
                            color: AppColors.inputText, size: 35),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Appuyez pour choisir une photo',
                          style:
                              GoogleFonts.poppins(color: AppColors.inputText),
                        ),
                      ],
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
                        const SnackBar(content: Text('Création du profil')),
                      );
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

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'webp'],
    );
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  uploadFile() async {
    final path = currentUser!.uid;
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref('Users').child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});
  }

  void subscribeToFirebase(context) async {
    try {
      await uploadFile();
      addUser(
        currentUser!.uid,
        FirstnameField.text.trim(),
        LastnameField.text.trim(),
      ).then(
        (value) {
          print(currentUser!.uid);
          Navigator.pushNamed(context, '/home');
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
