import 'package:flutter/material.dart';
import 'package:kosmos_app/profil/components/account_section.dart';
import 'package:kosmos_app/profil/components/cupertino_button.dart';
import 'package:kosmos_app/profil/components/link_section.dart';
import 'package:kosmos_app/profil/components/others_section.dart';
import 'package:kosmos_app/profil/components/parameters_section.dart';
import 'package:kosmos_app/profil/components/social_section.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/first_section.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: const [
          CupertinoWidget(),
        ],
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
      body: Container(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const firstSection(),
              const SizedBox(height: 20),
              const AccountSection(),
              const SizedBox(height: 20),
              const ParametersSection(),
              const SizedBox(height: 20),
              const OthersSection(),
              const SizedBox(height: 20),
              const LinkSection(),
              const SizedBox(height: 20),
              const SocialSection(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Edité par '),
                  Text(
                    'kosmos-digital.com',
                    style: GoogleFonts.poppins(
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
