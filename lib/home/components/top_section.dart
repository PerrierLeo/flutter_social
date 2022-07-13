import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:kosmos_app/profil/profil_page.dart';
import '../../services/get_user_data.dart';
import 'package:kosmos_app/myColors.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        'Bonjour, ',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.informationText,
                        ),
                      ),
                      GetUserData(currentUser!.uid, 'firstname', 14,
                          AppColors.informationText, FontWeight.w600),
                      const Text('👋'),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Fil d\'actualités',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 35),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                    ),
                    child: TextButton(
                      style:
                          TextButton.styleFrom(fixedSize: const Size(60, 60)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilPage(),
                          ),
                        );
                      },
                      child: const AvatarProfil(),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            color: AppColors.mentionLegal,
            height: 1,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Récents',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
