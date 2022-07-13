import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kosmos_app/profil/components/cupertino_photo.dart';
import '../../myColors.dart';
import '../../services/get_user_data.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;

FirebaseFirestore firestore = FirebaseFirestore.instance;

class firstSection extends StatefulWidget {
  const firstSection({Key? key}) : super(key: key);

  @override
  State<firstSection> createState() => _firstSectionState();
}

class _firstSectionState extends State<firstSection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 92,
            width: 92,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(75),
            ),
            child: const AvatarProfil(),
          ),
          SizedOverflowBox(
            size: const Size(10, 10),
            alignment: Alignment.center,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black.withOpacity(0.5),
              ),
              child: CupertinoPhotoWidget(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetUserData(currentUser!.uid, 'firstname', 20, Colors.black,
                  FontWeight.bold),
              const SizedBox(
                width: 5,
              ),
              GetUserData(currentUser!.uid, 'lastname', 20, Colors.black,
                  FontWeight.bold),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${currentUser!.email}',
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.informationText),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
              width: double.infinity,
              color: AppColors.inputBackground,
              height: 2)
        ],
      ),
    );
  }
}
