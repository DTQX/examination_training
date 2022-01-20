import 'package:examination_training/model/paper.dart';
import 'package:examination_training/test_paper/select/renderForm.dart';
import 'package:flutter/material.dart';

import '../../route_path.dart';

import 'package:examination_training/mock/papers.dart';
class RenderContent extends StatefulWidget {
  RenderContent({Key key}) : super(key: key);

  @override
  _RenderContentState createState() => _RenderContentState();
}

class _RenderContentState extends State<RenderContent> {

  String year = '';
  SubjectType subject = SubjectType.Reserve;

  List<Paper> papers = [];

  @override
  initState () {
    _getPapers();
    super.initState();
  }

  _getPapers () async {
    var ps = await getMockPaper();
    setState(() {
      papers = ps;
    });
  }

  _handleYearChange (String y) {
    setState(() => {
      year = y
    });
    _getPapers();
  }
  _handleSubjectChange (SubjectType s) {
    setState(() => {
      subject = s
    });
    _getPapers();
  }
  _handleChoosePaper (BuildContext ctx, Paper paper) {
    Navigator.pushNamed(ctx, RoutePath.DO_TEST, arguments: paper);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
        RenderForm(year: year, subject: subject, onYearChange: _handleYearChange, onSubjectChange: _handleSubjectChange),
        Container(
          height: 1,
          color: Colors.blueGrey[200]
        ),
        Column(
          children: papers.map((paper) => GestureDetector(
            onTap: () => _handleChoosePaper(context, paper),
            child: renderPaper(paper)
          )).toList(),
        )
      ],
    )
    );
  }

  renderPaper(Paper paper) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.blueGrey[50]))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(paper.title, style: TextStyle(fontSize: 16, color: Colors.black))
          ),
          Container(
            child: Row(
              children: [
                Text(paper.year),
                Icon(Icons.arrow_forward_ios, size: 14)
              ]
            )
          ),
        ]
      )
    );
  }
}
