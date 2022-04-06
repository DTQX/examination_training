import 'package:examination_training/net/request.dart';
import 'package:examination_training/net/response.dart';
import 'adaptor/base.dart';
import 'adaptor/http_adaptor.dart';

class Net {

  Net._();
  static Net _instance;
  static Net getInstance () {
    if (_instance == null) {
      _instance = Net._();
    }
    return _instance;
  }
  
  Future<T> send<T>(NetRequest req) async {
    NetResponse<T> response;
    var err;
    try {
      response = await sendByAdapter<T>(req);
    } catch (e) {
      err = e;
    }
    print("err${err}");
    print("response:${response}");

    return response.data;
  }

  Future<T> sendFile<T>(NetRequest req) async {
    NetResponse<T> response;
    var err;
    try {
      response = await sendFileByAdapter<T>(req);
    } catch (e) {
      err = e;
    }
    print("err${err}");
    print("response:${response}");

    return response.data;
  }

  Future sendByAdapter<T> (NetRequest req) async {

    NetAdapter ad = HttpAdapter();

    return ad.send<T>(req);
  }

  Future sendFileByAdapter<T> (NetRequest req) async {

    NetAdapter ad = HttpAdapter();

    return ad.sendFile<T>(req);
  }

}
