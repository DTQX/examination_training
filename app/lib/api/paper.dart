import 'package:examination_training/model/paper.dart';
import 'package:examination_training/net/net.dart';
import 'package:examination_training/net/request.dart';

class PaperRequest extends NetRequest {

  dynamic d;
  String p;

  PaperRequest(this.p, this.d);

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
Future queryPaperList (String data) {

  print('enet start: $data');
  
  NetRequest req = PaperRequest('/get_test_paper_list', data);

  return Net.getInstance().send<Object>(req);
}

Future getPaperDetail (String id) {

  print('enet start: $id');
  
  NetRequest req = PaperRequest('/get_test_paper', {'_id': id});

  return Net.getInstance().send<Object>(req);
}

Future<void> uploadPic (dynamic data) {
  NetRequest req = PaperRequest('/file_upload', data);

  return Net.getInstance().send(req);
}

Future<void> uploadAnswer (dynamic data) {
  NetRequest req = PaperRequest('/upload_answer', data);

  return Net.getInstance().send(req);
}
