import 'dart:io';

import 'package:examination_training/net/net.dart';
import 'package:examination_training/net/request.dart';

class CommonRequest extends NetRequest {

  File d;
  String p;
  File f;

  CommonRequest(this.p, this.f);

  @override
  data() {
    return d;
  }

  @override
  String path() {
    return p;
  }

  @override
  File file() {
    return f;
  }
}

// 获取试卷列表
Future uploadFile (File file) async {

  print('net start upload: $file');

  NetRequest req = CommonRequest('/file_upload', file);
  req.addHeader('Content-Type', 'multipart/form-data');

  return Net.getInstance().sendFile<Object>(req);
}

