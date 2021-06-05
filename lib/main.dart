import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guess_app/screens/home.dart';
import 'package:guess_app/screens/login.dart';
import 'package:guess_app/screens/register.dart';
import 'package:guess_app/screens/splash.dart';
import 'package:guess_app/screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SplashScreen(),
      routes: <String,WidgetBuilder>{
        "login" : (BuildContext context)=>LoginScreen(),
        "register" : (BuildContext context)=>RegisterScreen(),
        "welcome" : (BuildContext context)=>WelcomeScreen(),
      },
    );
  }
}


