import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guess_app/models/question.dart';
import 'package:guess_app/widgets/option.dart';

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({Key key, @required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(question.question,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black54),
          ),
          SizedBox(
            height: 12,
          ),
          ...List.generate(
            question.options.length,
              (index) => Option(
                index: index,
                text: question.options[index],
                press: () {}
              ),
          ),
        ],
      ),
    );
  }
}
