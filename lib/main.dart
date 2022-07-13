import 'package:kosmos_app/home/home_page.dart';
import 'package:kosmos_app/posts/create_description_page.dart';
import 'package:kosmos_app/posts/create_post_page.dart';
import 'package:kosmos_app/profil/profil_modification_page.dart';
import 'package:kosmos_app/profil/profil_page.dart';
import 'package:kosmos_app/profil/security_page.dart';
import 'package:kosmos_app/register/register_page.dart';

import './login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home/home_page.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  auth.authStateChanges().listen(
    (User? user) {
      if (user == null) {
        print('Utilisateur non connecté');
        runApp(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Navigation avec Flutter',
            initialRoute: '/',
            routes: {
              '/': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/home': (context) => const HomePage(),
            },
          ),
        );
      } else {
        print('Utilisateur connecté: ${user.email!}');
        runApp(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Navigation avec Flutter',
            initialRoute: '/home',
            routes: {
              '/home': (context) => const HomePage(),
              //Posts
              '/create_post': (context) => const CreatePostPage(),
              '/add_description': (context) => const CreateDescriptionPage(),
              //Profil
              '/profil': (context) => const ProfilPage(),
              '/profil_settings': (context) => const ProfilModificationPage(),
              '/security_settings': (context) => const SecurityPage(),
            },
          ),
        );
      }
    },
  );
}

class ScreenArguments {
  final String value;

  ScreenArguments({required String this.value});
}
