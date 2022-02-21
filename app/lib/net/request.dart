abstract class NetRequest {

  bool useHttps = true;

  String domain () {
    return 'qchtxq.api.cloudendpoint.cn';
  }

  String path();
  Object data();

  String Url () {
    Uri uri;
    String p = path();
    if (useHttps) {
      uri = Uri.https(domain(), p);
    } else {
      uri = Uri.http(domain(), p);
    }
    return uri.toString();
  }

  Map<String, String> headers = Map();
  NetRequest addHeader(String key, String value) {
    headers[key] = value;
    return this;
  }
}
