import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;

class CupertinoWidget extends StatelessWidget {
  const CupertinoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoButton(
          onPressed: () {
            Navigator.of(context).restorablePush(_modalBuilder);
          },
          child: const Icon(Icons.more_horiz, color: Colors.black)),
    );
  }

  static Route<void> _modalBuilder(BuildContext context, Object? arguments) {
    return CupertinoModalPopupRoute<void>(
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          message: const Text('Que souhaitez-vous faire ?'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: const Text(
                'Se déconnecter',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                try {
                  auth.signOut().then(
                    (value) {
                      Navigator.pushNamed(context, '/');
                    },
                  );
                } catch (error) {
                  print(error.toString());
                }
              },
            ),
            CupertinoActionSheetAction(
              child: const Text(
                'Supprimer mon profil',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                _showMailReception(context);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text(
              'Annuler',
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}

_showMailReception(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 350, maxWidth: 282),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Color.fromRGBO(146, 153, 164, 1),
                    ),
                  ),
                ],
              ),
              Text(
                'Supprimer mon',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(
                'compte',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Souhaitez-vous vraiment",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(167, 173, 181, 1),
                ),
              ),
              Text(
                "supprimer votre compte ?",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(167, 173, 181, 1),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 139,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: const Text(
                    'Oui',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                child: const Text(
                  'Non',
                  style: const TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    },
  );
}
