import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kosmos_app/myColors.dart';
import 'package:kosmos_app/profil/email_modification.dart';
import 'package:kosmos_app/profil/password_modification.dart';
import 'package:kosmos_app/services/get_user_data.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Sécurité',
          style: GoogleFonts.poppins(
              fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmailModificationPage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Adresse email',
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${currentUser?.email}',
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.informationText),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: AppColors.inputText,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PasswordModificationPage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Mot de passe',
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Dernière modification : il y a 3j',
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.informationText),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: AppColors.inputText,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
