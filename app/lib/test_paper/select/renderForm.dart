import 'package:flutter/material.dart';

const years = [
  {
    'label': '全部',
    'value': '',
  },
  {
    'label': '2020',
    'value': '2020',
  },
  {
    'label': '2019',
    'value': '2019',
  },
  {
    'label': '2018',
    'value': '2018',
  }
];

enum SubjectType {
  Reserve,
  Math,
  Science
}

const subjects = [
  {
    'label': '全部',
    'value': SubjectType.Reserve,
  },
  {
    'label': '数学',
    'value': SubjectType.Math,
  },
  {
    'label': '理综',
    'value': SubjectType.Science,
  }
];

class RenderForm extends StatelessWidget {

  RenderForm({ this.year, this.subject, this.onYearChange, this.onSubjectChange, Key key}):super(key: key);

  String year = '';
  SubjectType subject = SubjectType.Reserve;
  dynamic onYearChange;
  dynamic onSubjectChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          renderYears(year, onYearChange),
          renderSubject(subject, onSubjectChange)
        ],
      ),
    );
  }
}

renderSubject(SubjectType subject, onChange) {

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: subjects.map((sub) => Container(
        padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
        child: ElevatedButton(
          onPressed: () => {
            if (subject != sub['value']) {
              onChange(sub['value'])
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) {
              return subject == sub['value'] ? Colors.blue[700] : Colors.blue[100];
            })
          ),
          child: Text(sub['label'])
        )
    )).toList()
  );
}

renderYears(String year, onChange) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: years.map((y) => Container(
        padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
        child: ElevatedButton(
          onPressed: () => {
            if (year != y['value']) {
              onChange(y['value'])
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) {
              return year == y['value'] ? Colors.blue[700] : Colors.blue[100];
            })
          ),
          child: Text(y['label'])
        )
      )
    ).toList()
  );
}
