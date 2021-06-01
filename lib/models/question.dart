import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;

  Question({this.question, this.option1,this.option2,this.option3,this.option4});

  factory Question.fromJson(Map<String, dynamic> json) {
    print(json['question']);
    return Question(
      question: json['question'] as String,
      option1: json['option1'] as String,
      option2: json['option2'] as String,
      option3: json['option3'] as String,
      option4: json['option4'] as String
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "question": question,
      "option1": option1,
      "option2": option2,
      "option3":option3,
      "option4":option4
    };
  }
}
