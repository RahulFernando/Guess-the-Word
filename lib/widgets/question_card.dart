import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guess_app/models/question.dart';
import 'package:guess_app/provider/question_provider.dart';
import 'package:guess_app/screens/quiz.dart';
import 'package:guess_app/widgets/option.dart';
import 'package:provider/provider.dart';

class QuestionCard extends StatelessWidget {
  final int length;
  final Question question;

  const QuestionCard({Key key, @required this.length, @required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              question.question,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black54),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          ...List.generate(
            question.options.length,
            (index) => Option(index: index, text: question.options[index]),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                child: FlatButton(
                  onPressed: () {
                    Provider.of<QuestionProvider>(context, listen: false)
                        .checkAnswer(question);
                    if (length !=
                        Provider.of<QuestionProvider>(context, listen: false)
                            .questionNumber
                            .value) {
                      Future.delayed(Duration(seconds: 1), () {
                        Provider.of<QuestionProvider>(context, listen: false)
                            .nextQuestion();
                      });
                    } else {
                      int correct =
                          Provider.of<QuestionProvider>(context, listen: false)
                              .correctAnswers;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Future.delayed(Duration(seconds: 3), () {
                             Navigator.pushReplacementNamed(context, "home");
                            });
                            return AlertDialog(
                              title: Text("Your Score"),
                              content: Text('$correct out of $length'),
                            );
                          });
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color: Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }
}