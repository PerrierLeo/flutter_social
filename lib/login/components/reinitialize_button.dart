import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../myColors.dart';

class ReinitializeButton extends StatelessWidget {
  final emailReinitializeField = TextEditingController();

  ReinitializeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'mot de passe oublié ?',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.inputText,
          ),
        ),
        TextButton(
          onPressed: () {
            _showReinitializeModal(context);
          },
          child: Text(
            'Réinitialiser',
            style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  _showSimpleModalDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 282, maxWidth: 282),
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
                        child: Icon(
                          Icons.close,
                          color: AppColors.inputText,
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
                    "Vous avez reçu un email afin de",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.informationText,
                    ),
                  ),
                  Text(
                    "réinitialiser votre mot de passe.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.informationText,
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
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: const Text(
                        'Fermer',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showReinitializeModal(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return Container(
          // height: 800,
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(55.0),
                topRight: Radius.circular(55.0),
              ),
            ),
            child: Column(
              children: <Widget>[
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
                        'Réinitialiser mot de passe',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Entrez l’adresse email associée à votre",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.informationText,
                        ),
                      ),
                      Text(
                        "compte. Nous vous enverrons un email de",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.informationText,
                        ),
                      ),
                      Text(
                        "réinitialisation sur celle-ci.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.informationText,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Adresse email',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
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
                            child: TextField(
                              controller: emailReinitializeField,
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
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 54,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                sendPasswordReset(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                              ),
                              child: const Text(
                                'Réinitialiser',
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  sendPasswordReset(context) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailReinitializeField.text.trim());
    Navigator.pop(context);
    _showSimpleModalDialog(context);
  }
}
