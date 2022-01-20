import 'package:examination_training/test_paper/select/renderContent.dart';
import 'package:flutter/material.dart';

class SelectTestPaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('选择试卷'),
          ),
        ),
        body: RenderContent()
    );
  }
}

