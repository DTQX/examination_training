import '../request.dart';
import '../response.dart';

abstract class NetAdapter {
  Future<NetResponse<T>> send<T>(NetRequest req);
  Future<NetResponse<T>> sendFile<T>(NetRequest req);
}