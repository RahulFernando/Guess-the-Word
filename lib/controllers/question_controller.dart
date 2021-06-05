import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_app/models/question.dart';

class QuestionController {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // get all quesions
  Stream<List<Question>> getQuesions() {
    return _db.collection('questions').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Question.fromJson(doc.data(),doc.reference)).toList());
  }

  // get question by id
  Future<Question> getQuestion(String id) {
    return _db.collection('questions').document(id).get().then((value) {
      return Question.fromJson(value.data(),value.reference);
    });
  }
}
