import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String question;
  final List<String> options;
  final List<bool> answerList;
 

  Question({this.question, this.options, this.answerList});

  factory Question.fromJson(Map<String, dynamic> json) {
    print(json['question']);
    return Question(
      question: json['question'] as String,
      options: List<String>.from(json['options'].map((x) => x)),
      answerList: List<bool>.from(json['bool'].map((x) => x))
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "question": question,
      "options": options,
      "answerList": answerList

    };
  }
}
