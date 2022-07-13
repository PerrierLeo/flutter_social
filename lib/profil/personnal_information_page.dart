import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kosmos_app/profil/components/personnal_form.dart';

class PersonnalInformationPage extends StatefulWidget {
  const PersonnalInformationPage({Key? key}) : super(key: key);

  @override
  State<PersonnalInformationPage> createState() =>
      _PersonnalInformationPageState();
}

class _PersonnalInformationPageState extends State<PersonnalInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Infos personnelles',
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 10),
              PersonnalForm(),
            ],
          ),
        ),
      ),
    );
  }
}
