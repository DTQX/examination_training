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
  String name;
  int year;
  String subject;
  List<Question> questions;

  Paper(this.id, this.name, this.year, this.subject, this.questions);

  static Paper fromJson (Map json) {
    String _id = json['_id'];
    String _name = json['name'];
    int _year = json['year'];
    String _subject = json['subject'];
    return Paper(_id, _name, _year, _subject, []);
  }
}

class Question {
  String id;
  String qUrl;
  String subject;
  String aUrl;
  int dur = 0;

  Question(
    this.id,
    this.subject,
    this.qUrl,
    this.aUrl
  );

  static Question fromJson (Map json) {
    String _id = json['_id'];
    String _subject = json['subject'];
    String _qUrl = json['qUrl'];
    String _aUrl = json['aUrl'];
    return Question(_id, _subject, _qUrl, _aUrl);
  }
}
