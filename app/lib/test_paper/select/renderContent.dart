import 'package:examination_training/test_paper/select/renderForm.dart';
import 'package:flutter/material.dart';

import '../../route_path.dart';

class RenderContent extends StatefulWidget {
  RenderContent({Key key}) : super(key: key);

  @override
  _RenderContentState createState() => _RenderContentState();
}

class _RenderContentState extends State<RenderContent> {

  String year = '';
  SubjectType subject = SubjectType.Reserve;

  _handleYearChange (String y) {
    setState(() => {
      year = y
    });
  }
  _handleSubjectChange (SubjectType s) {
    setState(() => {
      subject = s
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   border: BoxBorder()
      // ),
      child: Column(
        children: [
          RenderForm(year: year, subject: subject, onYearChange: _handleYearChange, onSubjectChange: _handleSubjectChange),
          Container(
            height: 1,
            color: Colors.blueGrey[300]
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: ()=>{
                  Navigator.pushNamed(context, RoutePath.DO_TEST)
                },
                child: Text('试卷133'),
              ),
              ElevatedButton(
                child: Text('试卷2'),
                onPressed: ()=>{
                  Navigator.pushNamed(context, RoutePath.DO_TEST)
                },
              )
            ],
          )
        ],
      ),
    );
  }
}