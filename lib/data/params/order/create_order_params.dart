import 'package:dio/dio.dart';
import 'package:garage/data/models/dictionary/car_api_model.dart';
import 'package:garage/data/models/dictionary/car_model.dart';
import 'package:garage/data/models/dictionary/group_model.dart';

import '../../models/dictionary/car_vin_model.dart';
import '../../models/dictionary/city_model.dart';
import '../../models/dictionary/part_model.dart';

class CreateOrderParams {
  final String title;
  final CarApiModel? car;
  final CarVinModel? carVin;
  final PartModel part;
  final String? comment;
  final List<MultipartFile> photos;
  final CityModel city;

  CreateOrderParams({
    required this.title,
    this.car,
    this.carVin,
    required this.part,
    this.comment,
    required this.city,
    this.photos = const []
  });

  FormData toData() {
    final data = FormData.fromMap({
      'title': title,
      'part_id': part.id,
      'city_id': city.id,
      'comment': comment
    });
    if(car != null) {
      data.fields.add(MapEntry('car_id', car!.apiId));
    } else if(carVin != null) {
      data.fields.add(MapEntry('car_id', carVin!.carId));
    }
    print(data.fields);
    if(photos.isNotEmpty) {
      data.files.addAll(photos.map((e) {
        return MapEntry('photos[]', e);
      }) ?? []);
    }


    return data;
  }
}