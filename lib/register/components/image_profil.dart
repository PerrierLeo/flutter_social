import 'dart:io';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kosmos_app/services/get_user_data.dart';

class ImageProfil extends StatefulWidget {
  const ImageProfil({Key? key}) : super(key: key);

  @override
  State<ImageProfil> createState() => _ImageProfilState();
}

class _ImageProfilState extends State<ImageProfil> {
  PlatformFile? pickedFile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              uploadFile();
            },
            child: const Text('Upload file'),
          ),
          ElevatedButton(
            onPressed: () {
              selectFile();
            },
            child: const Text('Select file'),
          ),
          if (pickedFile != null)
            Column(
              children: [
                Text(pickedFile!.name),
                Image.file(
                  File(pickedFile!.path!),
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                )
              ],
            ),
        ],
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'webp'],
    );
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  uploadFile() async {
    final path = currentUser!.uid;
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref('Users').child(path);
    ref.putFile(file);
  }

  profilPhoto() async {}
}
