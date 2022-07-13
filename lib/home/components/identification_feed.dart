import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kosmos_app/myColors.dart';

import '../../services/get_user_data.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;

FirebaseFirestore firestore = FirebaseFirestore.instance;

class IdenfiticationFeed extends StatelessWidget {
  const IdenfiticationFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const AvatarProfil(),
                ),
              ],
            )
          ],
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GetUserData(currentUser!.uid, 'firstname', 16, Colors.white,
                    FontWeight.w600),
                const SizedBox(width: 10),
                GetUserData(currentUser!.uid, 'lastname', 16, Colors.white,
                    FontWeight.w600),
                Text(
                  '  22 min',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.informationText),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '''Lorem ipsum dolor sit amet, consectetur
adipiscing elit. Integer ac egestas dui.
Vestibulum at congue magna, a facilisis.
Praesent non magna sed lacus finibus
vulputate et eget mauris''',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.informationText),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
