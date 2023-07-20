import 'package:garage/core/services/isar_service.dart';
import 'package:isar/isar.dart';

import '../../../core/services/api/api_service.dart';
import '../../../core/services/api/interceptors/city_interceptor.dart';
import '../../models/dictionary/city_model.dart';

class CityRepository {
  static CityInterceptor? interceptor;
  static CityModel? city;

  static Future index() => ApiService.I.get('/cities')
      .then((value) => CityModel.fromListMap(value.data['list']));

  static Future write(CityModel city) async {
    await IsarService.I.writeTxn(() async {
      await IsarService.I.cityModels.put(city);
    });
  }

  static Future clear() async {
    await IsarService.I.cityModels.clear();
  }

  static Future<CityModel?> read() async {
    List<CityModel> cities = await IsarService.I.cityModels.where().findAll();
    if(cities.isNotEmpty) {
      city = cities[0];
      _addInterceptor(city!);
      return city;
    } else {
      return null;
    }
  }

  static _addInterceptor(CityModel city) {
    if(interceptor != null) {
      ApiService.removerInterceptor(interceptor!);
    }
    interceptor = CityInterceptor(city);
    ApiService.addInterceptor(interceptor!);
  }
}