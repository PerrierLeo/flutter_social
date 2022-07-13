import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kosmos_app/myColors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kosmos_app/services/get_user_data.dart';
import '../main.dart';
import 'dart:io';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Choisissez une image',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                selectFile();
              },
              child: Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: AppColors.informationText),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (pickedFile == null)
                      Column(
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: AppColors.informationText,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Appuyez pour choisir une photo',
                            style: TextStyle(color: AppColors.informationText),
                          ),
                        ],
                      ),
                    if (pickedFile != null)
                      Expanded(
                        child: Image.file(
                          File(pickedFile!.path!),
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (pickedFile != null) {
                    uploadFile();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                child: const Text(
                  'Suivant',
                ),
              ),
            ),
          ],
        ),
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

  Future uploadFile() async {
    final path = currentUser!.uid + DateTime.now().toString();
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref('Posts').child(path);

    var imageUrl;

    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(
      () async {
        var url = await ref.getDownloadURL();
        imageUrl = url.toString();
      },
    );

    firestore.collection('Posts').add({
      'id': currentUser?.uid,
      'image_url': imageUrl,
    }).then(
      (value) {
        print(value);
        Navigator.pushNamed(
          context,
          '/add_description',
          arguments: ScreenArguments(value: value.id),
        );
      },
    );
  }
}
