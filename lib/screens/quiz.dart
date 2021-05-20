import 'package:flutter/material.dart';
import 'package:guess_app/widgets/quiz_body.dart';

class QuizSreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('img/Logo.png', fit: BoxFit.cover, height: 60.0,),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Guess The Word',
                style: TextStyle(
                  fontFamily: 'Righteous',
                  fontSize: 20.0
                ),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(),
      body: QuizBody(),
    );
  }
}