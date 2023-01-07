import 'package:dio/dio.dart';

const String _defaultMessage = 'Something went wrong';

extension ExceptionExtension on Exception {
  String parseMessage() {
    final e = this;
    if (e is DioError) {
      return e.response?.data is Map
          ? e.response?.data['msg'] ?? _defaultMessage
          : _defaultMessage;
    } else {
      return _defaultMessage;
    }
  }
}