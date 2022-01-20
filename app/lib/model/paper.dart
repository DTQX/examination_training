enum SubjectType {
  Reserve,
  Math,
  Science
}

enum QuestionType {
  single,
  multi,
  shortAnswer
}

class Paper {
  String id;
  String title;
  String year;
  SubjectType subject;
  List<Question> qs;

  Paper(this.id, this.title, this.year, this.subject, this.qs);
}

class Question {
  String id;
  String title;
  String desc;
  List<String> content;
  QuestionType type;
  dynamic answer;

  Question(this.id, this.title, this.desc, this.content, this.type, this.answer);
}
