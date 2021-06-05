class Question {
  final String question;
  final List<bool> answers;
  final List<String> options;

  Question({this.question, this.answers, this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] as String,
      answers: List<bool>.from(json['answers'].map((y) => y)),
      options: List<String>.from(json['options'].map((x) => x)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "question": question,
      "answers": answers,
      "options": options
    };
  }
}
