import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guess_app/screens/app.dart';
import 'package:guess_app/screens/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginScreen());
}
