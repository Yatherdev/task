import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../Widgets/gradiant_scaffold.dart';
import '../Auth/login_page.dart';
import '../Screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }
  Future<void> _checkAuthentication() async {
    await Future.delayed(Duration(milliseconds: 2500)); // انتظار 2 ثانية لـ Splash
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // لو مسجل الدخول، اروح لـ HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // لو مش مسجل، اروح لـ LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Center(
        child: Lottie.asset(
          'Assets/animation/splash.json',
          width: 250,
          height: 250,
          fit: BoxFit.contain,
          onLoaded: (composition) {
            Future.delayed(composition.duration, _checkAuthentication );
          },
        ),
      ),
    );
  }
}
