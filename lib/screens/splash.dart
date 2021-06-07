import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:guess_app/screens/welcome.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnimatedSplashScreen(
          duration: 4000,
          splash: 'assets/img/Logo.png',
          splashIconSize: 130,
          nextScreen: WelcomeScreen(),
          splashTransition: SplashTransition.sizeTransition,
          pageTransitionType: PageTransitionType.bottomToTop,
          backgroundColor: Colors.purple,
        )
    );
  }
}
