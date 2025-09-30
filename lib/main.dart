import 'package:blood_bank/presentation/Auth/login_page.dart';
import 'package:blood_bank/presentation/Auth/signup_page.dart';
import 'package:blood_bank/presentation/Auth/userdata_page.dart';
import 'package:blood_bank/presentation/Screens/home_page.dart';
import 'package:blood_bank/presentation/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';   // import firebase core

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const UserDataScreen(),
    );
  }
}