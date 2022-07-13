import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSection extends StatelessWidget {
  const TextSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                'Connectez-vous ou',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 23, fontWeight: FontWeight.bold),
              ),
              Text(
                'créez un compte.',
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
