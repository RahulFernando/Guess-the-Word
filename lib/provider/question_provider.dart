import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guess_app/controllers/question_controller.dart';
import 'package:guess_app/models/question.dart';
import 'package:guess_app/screens/score_page.dart';

class QuestionProvider with ChangeNotifier {
  // data members
  final controller = QuestionController();
  RxInt _questionNumber = 1.obs;
  PageController _pageController = PageController();
  List<int> _selectedOptions = new List();
  int _correctAnswers = 0;

  // getters
  Stream<List<Question>> get questions => controller.getQuesions();
  RxInt get questionNumber => _questionNumber;
  PageController get pageController => _pageController;
  List<int> get selectedOptions => _selectedOptions;
  int get correctAnswers => _correctAnswers;

  // update question number
  void upateQuesionNumber(int index) {
    this._questionNumber.value = index + 1;
  }

  // select answer
  void lockAnswer(int index) {
    _selectedOptions.add(index);
  }

  // check answer
  bool checkAnswer(Question question) {
    print("Correct: $_correctAnswers");

    var tempList = new List();
    var noOfCorrectlyIdentified = 0;

    for (int i = 0; i < question.answers.length; i++) {
      if (question.answers[i] == true) {
        tempList.add(i);
      }
    }

    for (int j = 0; j < _selectedOptions.length; j++){
      for (int k = 0; k < tempList.length; k++) {
        if (tempList[k] == _selectedOptions[j]) {
          noOfCorrectlyIdentified++;
        }
      }
    }

    if (noOfCorrectlyIdentified == tempList.length) {
      _correctAnswers++;
     return true;
    }

    return false;
  }

  // move to next question
  void nextQuestion() {
    if (_questionNumber.value != questions.length) {
      _pageController.nextPage(duration: Duration(microseconds: 250), curve: Curves.ease);
    }
  }
}
