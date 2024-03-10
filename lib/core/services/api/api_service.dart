import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static late Dio _dio;

  ApiService();

  ApiService.initialize() {
    _dio = Dio();
    _dio.options.baseUrl = dotenv.env['BASE_URL']!;
    _dio.options.headers.addAll({
      'Accept': 'application/json',
    });
    addInterceptor(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      maxWidth: 90
    ));
  }

  static Dio get I => _dio;

  static addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  static removerInterceptor(Interceptor interceptor) {
    _dio.interceptors.remove(interceptor);
  }
}