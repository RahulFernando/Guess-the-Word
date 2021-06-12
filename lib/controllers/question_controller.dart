import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_app/models/question.dart';

class QuestionController {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // get all quesions
  Stream<List<Question>> getQuesions() {
    return _db.collection('questions').snapshots().map((snapshot) =>
        snapshot
            .docs
            .map((doc) => Question.fromJson(doc.data(), doc.reference))
            .toList());
  }

  getAllQuestions() {
    return _db.collection('questions').snapshots();
  }

  // get question by id
  Future<Question> getQuestion(String id) {
    return _db.collection('questions').document(id).get().then((value) {
      return Question.fromJson(value.data(), value.reference);
    });
  }

//add question , options and correct answers
  addQuestion(Question questionObj) async {
    try {
      _db.runTransaction((Transaction transaction) async {
        await _db.collection('questions').doc().set(questionObj.toMap());
      });
    } catch (e) {
      print(e.toString());
    }
  }

//update questions, options and correct answers.
  updateQuestion(Question questionObj, String question,
      List<String> optionsList, List<bool> answerList) {
    try {
      _db.runTransaction((transaction) async {
        await transaction.update(questionObj.id, {
          'question': question,
          'options': optionsList,
          'answers': answerList
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

//delete question
  deleteQuestion(Question question) {
    _db.runTransaction((Transaction transaction) async {
      await transaction.delete(question.id);
    });
  }

  ///Deletes All the questions
  deleteAllQuestions(List<Question> questionsList) {
    _db.runTransaction((Transaction transaction) async {
      await questionsList.forEach((question) {
        transaction.delete(question.id);
      });
    });
  }
}
