import 'dart:convert';
import 'dart:io';

import 'package:examination_training/net/response.dart';
import 'package:examination_training/net/request.dart';
import 'base.dart';
import 'package:http/http.dart' as http;

class HttpAdapter extends NetAdapter {
  @override
  Future<NetResponse<T>> send<T>(NetRequest req) async {
    var res, err;

    var url = Uri.parse(req.Url());
    var data = json.encode(req.data());

    print("header: ${req.headers}");
    try {
      res = await http.post(url, headers: req.headers, body: data);
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

  @override
  Future<NetResponse<T>> sendFile<T>(NetRequest req) async {
    var res, err;

    var url = Uri.parse(req.Url());
    // var data = json.encode(req.data());
    File data = req.file();

    print("header: ${req.headers}");
    final request = http.MultipartRequest('POST', url);
    // request.fields['myFile'] = data.path;
    request.files.add(await http.MultipartFile.fromPath('myFile', data.path));
    request.headers['Content-Type'] = 'application/form-data';
    try {
      // res = await http.post(url, headers: req.headers, body: data);
      res = await request.send();
      res = await res.stream.transform(utf8.decoder).join();
      res = json.decode(res);
      print('sendFile====>>> ${res}');
    } catch (e) {
      err = e;
      print('sendFile====>>> ${e}');
    }

    if (err != null) {
      throw Error();
    }
    return NetResponse<T>(
      code: res['code'],
      msg: res['msg'],
      data: res['data'] as T,
      request: req
    );
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