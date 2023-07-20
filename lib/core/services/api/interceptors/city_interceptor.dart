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
    } else {
      options.data.addAll({
        'city_id': city.id
      });
    }
    
    super.onRequest(options, handler);
  }
}