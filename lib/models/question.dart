class Question {
  final int id;
  final String question;
  final int answer;
  final List<bool> answers;
  final List<String> options;

  Question({this.id, this.question, this.answer, this.answers, this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int,
      question: json['question'] as String,
      answer: json['answer'] as int,
      answers: List<bool>.from(json['answers'].map((y) => y)),
      options: List<String>.from(json['options'].map((x) => x)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "question": question,
      "answer": answer,
      "answers": answers,
      "options": options
    };
  }
}
