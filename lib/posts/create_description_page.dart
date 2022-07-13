import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import 'components/description_form.dart';

class CreateDescriptionPage extends StatefulWidget {
  const CreateDescriptionPage({Key? key}) : super(key: key);

  @override
  State<CreateDescriptionPage> createState() => _CreateDescriptionPageState();
}

class _CreateDescriptionPageState extends State<CreateDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments arguments =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Ajouter une description',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 20),
              DescriptionForm(
                value_ID: arguments.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
