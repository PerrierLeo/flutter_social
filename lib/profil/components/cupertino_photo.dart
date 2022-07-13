import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;

class CupertinoPhotoWidget extends StatelessWidget {
  PlatformFile? pickedFile;

  CupertinoPhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit_sharp, size: 15, color: Colors.white),
      onPressed: () {
        Navigator.of(context).restorablePush(_modalBuilder);
      },
    );
  }

  static Route<void> _modalBuilder(BuildContext context, Object? arguments) {
    return CupertinoModalPopupRoute<void>(
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          message: const Text('Modifier votre photo de profil'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: const Text(
                'Prendre une photo/video',
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text(
                'Bibliothèque photos/vidéos',
              ),
              onPressed: () {
                Navigator.pop(context);
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
