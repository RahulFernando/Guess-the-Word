import 'package:flutter/material.dart';
import 'package:guess_app/controllers/question_controller.dart';
import 'package:guess_app/provider/question_provider.dart';
import 'package:provider/provider.dart';

class ScorePage extends StatelessWidget {
  final int total;
  final score;

  const ScorePage({Key key, @required this.total, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          // onTap: () => Get.to(
          //       () => HomePage(),
          // ),
          child: Icon(
            Icons.navigate_before,
            color: Colors.black54,
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height / 2,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/images/score.jpg'),
              //       fit: BoxFit.fitWidth,
              //     ),
              //   ),
              // ),
              Text(
                'Your Score $score',
                style: Theme.of(context).textTheme.headline4.copyWith(
                  color: Colors.black54,
                ),
              ),
              // Text(
              //   (_controller.numberOfCorrectAnswer == null)
              //       ? '0/${_controller.questions.length}'
              //       : '${_controller.numberOfCorrectAnswer}/${_controller.questions.length}',
              //   style: Theme.of(context).textTheme.headline4.copyWith(
              //     color: Colors.black54,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
