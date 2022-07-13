import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;

final User? currentUser = auth.currentUser;

class GetUserData extends StatelessWidget {
  final String documentId;
  final String nameField;
  final double sizeFont;
  final colorFont;
  final weiFont;

  const GetUserData(this.documentId, this.nameField, this.sizeFont,
      this.colorFont, this.weiFont);
  @override
  Widget build(BuildContext context) {
    CollectionReference users = firestore.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(data[nameField],
              style: GoogleFonts.poppins(
                fontSize: sizeFont,
                color: colorFont,
                fontWeight: weiFont,
              ));
        }
        return Text('');
      },
    );
  }
}

class AvatarProfil extends StatefulWidget {
  const AvatarProfil({
    Key? key,
  }) : super(key: key);

  @override
  State<AvatarProfil> createState() => _AvatarProfilState();
}

class _AvatarProfilState extends State<AvatarProfil> {
  String? userPhotoUrl;
  String defaultUrl = 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png';

  void initState() {
    super.initState();
    getProfilImage();
  }

  getProfilImage() {
    Reference ref = storage.ref().child("Users/${currentUser!.uid}");
    ref.getDownloadURL().then((downloadUrl) {
      setState(() {
        userPhotoUrl = downloadUrl.toString();
      });
    }).catchError((e) {
      setState(() {
        print('Un problème est survenu: ${e.error}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: userPhotoUrl == null
            ? NetworkImage(defaultUrl)
            : NetworkImage(userPhotoUrl!),
      ),
    );
  }
}
