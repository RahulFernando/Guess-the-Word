import 'package:cloud_firestore/cloud_firestore.dart';

class Question {

  final String question;
  final List<bool> answers;
  final List<String> options;

  DocumentReference id;

  Question({this.id, this.question, this.answers, this.options});
  
  factory Question.fromJson(Map<String, dynamic> json , DocumentReference docRef) {
    return Question(
      id: docRef,
      question: json['question'] as String,
      answers: List<bool>.from(json['answers'].map((y) => y)),
      options: List<String>.from(json['options'].map((x) => x)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "question": question,
      "answers": answers,
      "options": options
    };
  }
}
