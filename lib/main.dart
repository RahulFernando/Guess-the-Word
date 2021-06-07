import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guess_app/screens/home.dart';
import 'package:guess_app/screens/login.dart';
import 'package:guess_app/screens/quiz.dart';
import 'package:guess_app/screens/quizAdmin.dart';
import 'package:guess_app/screens/register.dart';
import 'package:guess_app/screens/splash.dart';
import 'package:guess_app/screens/welcome.dart';
import './screens/quizAdminWelcomeSplash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: _auth.currentUser != null ? HomeScreen() : SplashScreen(),
      routes: <String, WidgetBuilder>{
        "login": (BuildContext context) => LoginScreen(),
        "register": (BuildContext context) => RegisterScreen(),
        "welcome": (BuildContext context) => WelcomeScreen(),
        "quiz": (BuildContext context) => QuizScreen(),
        "home": (BuildContext context) => HomeScreen(),
        "admin": (BuildContext context) => QuizAdminDemo(),
        "adminWelcome":(BuildContext context) => QuizAdminWelcomeSplashScreen(),
      },
    );
  }
}
