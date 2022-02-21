import 'dart:convert';

import 'package:examination_training/net/response.dart';
import 'package:examination_training/net/request.dart';
import 'base.dart';
import 'package:http/http.dart' as http;

class HttpAdapter extends NetAdapter {
  @override
  Future<NetResponse<T>> send<T>(NetRequest req) async {
    var res, err;

    var url = Uri.parse(req.Url());
    try {

      res = await http.post(url, headers: req.headers, body: req.data());
      print('11====>>> ${json.decode(res.body)['data']}');
    } catch (e) {
      err = e;
      print('11eee====>>> ${e}');
    }

    if (err != null) {
      throw Error();
    }
    return buildRes<T>(res, req);
  }
}

NetResponse buildRes<T>(http.Response res, NetRequest req) {
  var body = json.decode(res.body);
  print('=====>888');

  var re = NetResponse<T>(
    code: body['code'],
    msg: body['msg'],
    data: body['data'] as T,
    request: req
  );
  print('=====>999');
  return re;
}