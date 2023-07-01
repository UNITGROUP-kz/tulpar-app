import 'package:dio/dio.dart';
import 'package:garage/core/services/api/api_service.dart';

class AuthInterceptor extends Interceptor {
  final String token;

  AuthInterceptor(this.token);


  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return ApiService.I.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options
    );
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Authorization': 'Bearer $token'
    });
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if(err.response?.statusCode == 403) {
      // _retry(err.requestOptions);
      print('Authorization Error');
    }
    super.onError(err, handler);
  }
}