import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:examination_training/api/paper.dart';
import 'package:examination_training/api/common.dart';
import 'package:examination_training/model/paper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
  Timer _timer;
  int currentTime = 0;
  File image;

  @override
  initState() {
    super.initState();
    _getCameras();
    _initTimer();
  }

  @override
  dispose() {
    controller?.dispose();
    super.dispose();
    _timer?.cancel();
  }

  _initTimer () {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (currentTime > 100) {
        _timer.cancel();
      }
      setState(() {
        currentTime++;
      });
    });
  }

  _getQs (String id) async {
    var p = await getPaperDetail(id);
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
    final File imageFile = File(file.path);
    print('imageFile:${imageFile.path}');
    // file.saveTo('./');
    // uploadFile(file.toString());
    setState(() {
      showCamera = false;
      image = imageFile;
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
    Paper pa = ModalRoute.of(context).settings.arguments;
    print('build:$pa');
    if (paper == null) {
      _getQs(pa.id);
      paper = pa;
    }
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
      appBar: AppBar(
        actions: [Text(currentTime.toString())] 
      ),
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
        image != null ? Image.file(image) : Text('answer')
      ]
    );
  }
}