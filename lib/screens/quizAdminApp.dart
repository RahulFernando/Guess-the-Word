import 'package:flutter/material.dart';
import '../screens/quizAdmin.dart';


class QuizAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test',
      home: QuizAdminDemo(),
    );
  }
}