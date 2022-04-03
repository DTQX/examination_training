import 'dart:io';

import 'package:examination_training/net/net.dart';
import 'package:examination_training/net/request.dart';
import 'package:http/http.dart' as http;

class CommonRequest extends NetRequest {

  dynamic d;
  String p;

  CommonRequest(this.p, this.d);

  @override
  data() {
    return d;
  }

  @override
  String path() {
    return p;
  }
}

// 获取试卷列表
Future uploadFile (File file) async {

  print('net start upload: $file');

  var data = await http.MultipartFile.fromPath(
    "myFile",
    file.path
  );
  
  NetRequest req = CommonRequest('/file_upload', data);
  req.addHeader('Content-Type', 'multipart/form-data');

  return Net.getInstance().send<Object>(req);
}

