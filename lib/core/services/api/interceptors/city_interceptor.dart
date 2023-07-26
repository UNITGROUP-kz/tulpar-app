import 'package:dio/dio.dart';

import '../../../../data/models/dictionary/city_model.dart';

class CityInterceptor extends Interceptor {
  final CityModel city;

  CityInterceptor(this.city);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if(options.method == 'GET') {
      options.queryParameters.addAll({
        'city_id': city.id
      });
    } else if(options.method == 'POST') {
        print(options.data.runtimeType);
      // if(options.data is FormData) {}
      // else {
      //   options.data.addAll({
      //   'city_id': city.id
      // });
    }
    
    super.onRequest(options, handler);
  }
}