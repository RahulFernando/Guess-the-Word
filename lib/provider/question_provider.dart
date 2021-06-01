import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guess_app/controllers/question_controller.dart';
import 'package:guess_app/models/question.dart';

class QuestionProvider with ChangeNotifier {
  final controller = QuestionController();
  RxInt _questionNumber = 1.obs;

  // getters
  Stream<List<Question>> get questions => controller.getQuesions();
  RxInt get questionNumber => _questionNumber;

  void upateQuesionNumber(int index) {
    _questionNumber.value = index + 1;
  }
}
