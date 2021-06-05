import 'package:flutter/material.dart';
import 'package:guess_app/screens/quiz.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: QuizScreen(),
      ),
      theme: ThemeData(
        primaryColor: Colors.purple
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
