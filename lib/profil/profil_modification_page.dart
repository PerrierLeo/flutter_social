import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kosmos_app/myColors.dart';
import 'package:kosmos_app/profil/personnal_information_page.dart';

class ProfilModificationPage extends StatefulWidget {
  const ProfilModificationPage({Key? key}) : super(key: key);

  @override
  State<ProfilModificationPage> createState() => _ProfilModificationPageState();
}

class _ProfilModificationPageState extends State<ProfilModificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Modifier',
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
      body: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PersonnalInformationPage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(30),
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
                          'Informations personnelles',
                          style: GoogleFonts.poppins(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Nom, prénom, date de naissance..',
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
    );
  }
}
