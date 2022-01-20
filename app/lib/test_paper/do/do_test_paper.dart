import 'package:camera/camera.dart';
import 'package:examination_training/model/paper.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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

  @override
  initState() {
    super.initState();
    _getCameras();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
  
  _getCameras () async {
    cameras = await availableCameras();
    print('====>${cameras.length}');
    if (cameras != null && cameras.length > 0) {
      controller = CameraController(cameras[0], ResolutionPreset.max);
      print('====>${cameras.length},${controller.cameraId}');
    }
  }

  _handleLove () {

  }
  _handleSubmit () async {
    if (controller == null) {
      await _getCameras();
    }
    await controller.initialize();
    // final path = join((await getTemporaryDirectory()).path, 'pic.png');
    final file = await controller.takePicture();
    print(file.name);
  }
  _handlePrev () {
    if (activeIndex != 0) {
      setState(() {
        activeIndex -= 1;
      });
    }
  }
  _handleNext () {
    if ((activeIndex + 1) != paper.qs.length) {
      setState(() {
        activeIndex += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    paper = ModalRoute.of(context).settings.arguments;
    question = paper.qs[activeIndex];

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            renderQuestion(context, question)
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text('${activeIndex + 1}、${q.title}'),
          ),
          ...q.content.map((c) => Container(
            child: Image(image: AssetImage(c))
          )).toList()
        ]
      )
    );
  }
}