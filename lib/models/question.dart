import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  
  final String question;
  final List<String> options;
  final List<bool> answers;

  DocumentReference id;
  

  Question({this.question, this.options, this.answers,this.id});

  factory Question.fromJson(Map<String, dynamic> json,DocumentReference docRef) {
    print(json['question']);
    return Question(
      id:docRef,
      question: json['question'] as String,
      options: List<String>.from(json['options'].map((x) => x)),
      answers: List<bool>.from(json['answerList'].map((x) => x)),
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "question": question,
      "options": options,
      "answerList": answers,
      "id":id

    };
  }
}
