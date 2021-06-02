import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  
  final String question;
  final List<String> options;
  final List<bool> answerList;

  DocumentReference id;


  Question({this.question, this.options, this.answerList,this.id});

  factory Question.fromJson(Map<String, dynamic> json,DocumentReference docRef) {
    print(json['question']);
    return Question(
      id:docRef,
      question: json['question'] as String,
      options: List<String>.from(json['options'].map((x) => x)),
      answerList: List<bool>.from(json['answerList'].map((x) => x)),
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "question": question,
      "options": options,
      "answerList": answerList,
      "id":id

    };
  }
}
