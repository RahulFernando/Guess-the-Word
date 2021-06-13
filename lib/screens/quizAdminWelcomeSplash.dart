import 'dart:async';
import 'package:flutter/material.dart';
import 'package:guess_app/screens/quizAdmin.dart';
import 'package:guess_app/utils/color.dart';


class QuizAdminWelcomeSplashScreen extends StatefulWidget {
  @override
  _QuizAdminWelcomeSplashScreen createState() => _QuizAdminWelcomeSplashScreen();
}

class _QuizAdminWelcomeSplashScreen extends State<QuizAdminWelcomeSplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => QuizAdminDemo()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (  
      backgroundColor: purpleColors,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Image.asset('assets/img/Logo.png'),
            ),
          ),
          SizedBox(
            height: 50,
             child: Text(
              'Welcome to Guess The Word Admin App !',
              style: TextStyle(fontSize: 18,color: Colors.white),
              
            ),
          ),
        ],
      ),
    );
  }
}
