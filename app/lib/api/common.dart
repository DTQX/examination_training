import 'package:examination_training/net/net.dart';
import 'package:examination_training/net/request.dart';
import 'package:http/http.dart';

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
Future uploadFile (String file) {

  print('enet start: $file');
  
  NetRequest req = CommonRequest('/file_upload', file);
  req.addHeader('Content-Type', 'multipart/form-data');

  return Net.getInstance().send<Object>(req);
}

