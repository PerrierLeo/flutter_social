import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilTextSection extends StatelessWidget {
  const ProfilTextSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                'Créez votre profil',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }
}
