import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guess_app/controllers/question_controller.dart';
import 'package:guess_app/models/question.dart';
import 'package:guess_app/provider/question_provider.dart';
import 'package:guess_app/widgets/option.dart';
import 'package:provider/provider.dart';

import 'question_card.dart';

class QuizBody extends StatefulWidget {
  const QuizBody({Key key}) : super(key: key);

  @override
  _QuizBodyState createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  @override
  Widget build(BuildContext context) {
  final questions = Provider.of<List<Question>>(context);

    return Stack(
      children: [
        SafeArea(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(
                    () => Text.rich(
                    TextSpan(
                      text: Provider.of<QuestionProvider>(context).questionNumber == null
                        ? ''
                        : "${Provider.of<QuestionProvider>(context).questionNumber}",
                      style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: Colors.black54),
                      children: [
                        TextSpan(
                            text: questions != null
                                ? "/${questions.length}"
                                : '',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.black54)),
                      ]
                    )
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: questions != null 
                  ? PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      controller: Provider.of<QuestionProvider>(context).pageController,
                      onPageChanged: Provider.of<QuestionProvider>(context).upateQuesionNumber,
                      itemCount: questions.length,
                      itemBuilder: (context, index) => QuestionCard(
                          length: questions.length,
                          question: questions[index]
                      ),)
                  : Center(child: CircularProgressIndicator(),),
              ),
            ],
          ),
        )),
      ],
    );
  }

}
