import 'package:dio/dio.dart';

class ErrorModel {
  final List<String> messages;

  ErrorModel(this.messages);

  static ErrorModel _parseDio(DioException error) {
    dynamic data = error.response?.data;
    print(data);
    if(data?['message'] != null) {
      return ErrorModel([data['message']]);
    } else if(data?['errors'] is List) {
      return ErrorModel(data['errors']);
    } else if(data?['errors'] is Map) {
      return ErrorModel(data['errors'].map((val)=> val));
    }
    return ErrorModel.nothing;
  }

  static ErrorModel get nothing => ErrorModel(['Unknown_error']);

  factory ErrorModel.parse(data) {
    if(data is DioException) {
      return ErrorModel._parseDio(data);
    }
    return ErrorModel.nothing;
  }
}