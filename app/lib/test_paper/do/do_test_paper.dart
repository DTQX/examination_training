import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:examination_training/api/paper.dart';
import 'package:examination_training/api/common.dart';
import 'package:examination_training/model/paper.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/line_scale_pulse_out_indicator.dart';

class DoTestPaper extends StatefulWidget {

  @override
  _DoTestPaperState createState() => _DoTestPaperState();
}

class _DoTestPaperState extends State<DoTestPaper> {

  Paper paper;
  int activeIndex;
  List<CameraDescription> cameras;
  CameraController controller;
  bool showCamera = false;
  Timer _timer;
  String imageUrl;

  final MAX_DURATION = 600;

  @override
  initState() {
    super.initState();
    _getCameras();
  }

  @override
  dispose() {
    controller?.dispose();
    super.dispose();
    _timer?.cancel();
  }

  _initTimer () {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (activeIndex == null) {
        return;
      }
      // print('timer, activeIndex: $activeIndex, questionId: ${paper.questions[activeIndex].id}');
      paper.questions[activeIndex].dur ++;
      setState(() {});
    });
  }

  _getQs (String id) async {
    dynamic p = await getPaperDetail(id);
    Paper pp = Paper.fromJson(p);
    List qs = p['questions'];
    pp.questions = qs.map((q) => Question.fromJson(q)).toList();

    setState(() {
      paper = pp;
      activeIndex = 0;
    });
    _initTimer();
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
    setState(() {
      showCamera = false;
    });
    final f = await uploadFile(imageFile);
    setState(() {
      imageUrl = f['url'];
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
    if (paper == null) {
      _getQs(pa.id);
    }
    if (activeIndex == null) {
      return Scaffold(
        appBar: AppBar(title: Text('题目加载中...')),
        body: Container(
          alignment: Alignment.center,
          child: Loading(indicator: LineScalePulseOutIndicator(), size: 64, color: Colors.blue[300])
        )
      );
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
    var number = paper.questions[activeIndex].dur ?? 0;
    var sec = (number % 60).floor();
    var min = (number / 60).floor();
    return Scaffold(
      appBar: AppBar(
        title: Text('第${activeIndex + 1}题'),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 16),
            child: Text('${min < 10 ? '0$min' : min.toString()}:${sec < 10 ? '0$sec' : sec.toString()}')
          )
        ] 
      ),
      body: Container(
        child: ListView(
          children: [
            renderQuestion(),
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
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(activeIndex != 0 ? null : Colors.grey[300])),
            child: Text("上一题"),
            onPressed: _handlePrev,
          ),
          OutlinedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(activeIndex == paper.questions.length - 1 ? null : Colors.grey[300])),
            child: Text("下一题"),
            onPressed: _handleNext,
          )
        ],
      )
    );
  }

  renderQuestion() {

    if (paper == null || paper.questions == null || paper.questions.length <= 0) {
      return Container();
    }
    Question q = paper.questions[activeIndex];


    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      child: Image.network(q.qUrl),
    );
  }

  renderAnswer (BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Text('答案')
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]), borderRadius: BorderRadius.all(Radius.circular(8))),
          width: 300,
          height: 600,
          margin: EdgeInsets.only(left: 16),
          child: imageUrl != null ? 
            Image.network(imageUrl, width: 300, height: 600)
            :
            paper.questions[activeIndex].aUrl != null ?
              Image.network(paper.questions[activeIndex].aUrl, width: 300, height: 600)
              :
              Text('请上传答案')
        )
      ]
    );
  }
}