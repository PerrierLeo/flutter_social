import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kosmos_app/myColors.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;
final storage = FirebaseStorage.instance;

class EmailInputSection extends StatelessWidget {
  final emailField = TextEditingController();

  EmailInputSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Adresse email*',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: 54,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(247, 247, 248, 1),
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextField(
                controller: emailField,
                decoration: InputDecoration(
                  hintText: '${currentUser?.email}',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(146, 153, 164, 1),
                  ),
                ),
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
                  subscribeToFirebase(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                child: const Text(
                  'Enregistrer',
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '* Les champs sont obligatoires',
                  style: GoogleFonts.poppins(color: AppColors.informationText),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
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
                  'jonh.do@example.com',
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
      await currentUser?.updateEmail(emailField.text.trim()).then(
        (value) {
          print(currentUser!.email);
          emailField.clear();
          _showMailReception(context);
        },
      );
    } catch (error) {
      print(error.toString());
    }
  }
}
