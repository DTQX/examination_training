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

  static Paper formJson (Map json) {
    String _id = json['_id'];
    String _name = json['name'];
    int _year = json['year'];
    String _subject = json['subject'];
    // List qs = json['questions'];
    // if (qs == null) {
    //   qs = [];
    // }
    // print('===>>>>>4${qs}');
    return Paper(_id, _name, _year, _subject, []);
  }
}

class Question {
  String id;
  String qUrl;
  String subject;
  String aUrl;

  Question(
    this.id,
    this.subject,
    this.qUrl,
    this.aUrl
  );

  static Question formJson (Map json) {
    String _id = json['_id'];
    String _subject = json['subject'];
    String _qUrl = json['qUrl'];
    String _aUrl = json['aUrl'];
    return Question(_id, _subject, _qUrl, _aUrl);
  }
}
