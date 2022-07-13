import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kosmos_app/profil/components/email_input_section.dart';

class EmailModificationPage extends StatefulWidget {
  const EmailModificationPage({Key? key}) : super(key: key);

  @override
  State<EmailModificationPage> createState() => _EmailModificationPageState();
}

class _EmailModificationPageState extends State<EmailModificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Adresse email',
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
        body: EmailInputSection());
  }
}
