import 'dart:ffi';

import 'package:camera/camera.dart';
import 'package:examination_training/api/paper.dart';
import 'package:examination_training/model/paper.dart';
import 'package:flutter/material.dart';

class DoTestPaper extends StatefulWidget {

  @override
  _DoTestPaperState createState() => _DoTestPaperState();
}

class _DoTestPaperState extends State<DoTestPaper> {

  Paper paper;
  int activeIndex = 0;
  Question question;
  List<CameraDescription> cameras;
  CameraController controller;
  bool showCamera = false;

  @override
  initState() {
    super.initState();
    _getCameras();
  }

  @override
  dispose() {
    controller?.dispose();
    super.dispose();
  }

  _getQs () async {
    var p = await getPaperDetail(paper.id);
    print('====>>>> p: $p');
  }
  
  _getCameras () async {
    cameras = await availableCameras();
    if (cameras != null && cameras.length > 0) {
      controller = CameraController(cameras[0], ResolutionPreset.max);
    }
  }

  _handleLove () {

  }
  _handleSubmit () async {
    if (controller == null) {
      await _getCameras();
      if (controller == null) {
        return;
      }
    }
    await controller.initialize();
    setState(() {
      showCamera = true;
    });
  }
  _takePic () async {
    final XFile file = await controller.takePicture();
    print('file:${file.name}-${file.length()}');
    file.saveTo('./');
    setState(() {
      showCamera = false;
    });
  }
  _handlePrev () {
    if (activeIndex != 0) {
      setState(() {
        activeIndex -= 1;
      });
    }
  }
  _handleNext () {
    if ((activeIndex + 1) != paper.questions.length) {
      setState(() {
        activeIndex += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    paper = ModalRoute.of(context).settings.arguments;
    _getQs();
    print('build:$paper');
    if (paper.questions != null && paper.questions.length > 0) {
      question = paper.questions[activeIndex];
    }

    if (showCamera) {
      return CameraPreview(
        controller,
        child: Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Center(
            child: FloatingActionButton(
              onPressed: _takePic,
              child: Icon(Icons.add_a_photo_rounded, size: 48)
            )
          )
        )
      );
    }

    return renderContent(context);
  }

  renderContent (BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            question != null ? renderQuestion(context, question) : Container(),
            renderAnswer(context)
          ]
        )
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: _handleLove,
            child: Text('收藏'),
          ),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: Text('提交'),
          ),
          OutlinedButton(
            child: Text("上一题"),
            onPressed: _handlePrev,
          ),
          OutlinedButton(
            child: Text("下一题"),
            onPressed: _handleNext,
          )
        ],
      )
    );
  }

  renderQuestion(BuildContext context, Question q) {

    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      child: Image(image: AssetImage(q.qUrl)),
    );
  }

  renderAnswer (BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text('答案')
        ),
        Image(image: AssetImage('images/p1.png'))
      ]
    );
  }
}