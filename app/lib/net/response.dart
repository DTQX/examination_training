import 'package:examination_training/net/request.dart';

class NetResponse<T> {
  int code;
  String msg;
  T data;
  NetRequest request;

  NetResponse({
    this.code,
    this.msg,
    this.data,
    this.request
  });

  // fromJson (Map json) {

  // }
}
