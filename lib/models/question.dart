class Question {
  final int id;
  final String question;
  final int answer;
  final List<String> options;

  Question({this.id, this.question, this.answer,this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    print(json['question']);
    return Question(
      id: json['id'] as int,
      question: json['question'] as String,
      answer: json['answer'] as int,
      options: List<String>.from(json['options'].map((x) => x)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "question": question,
      "answer": answer,
      "options": options
    };
  }
}
