import 'package:dio/dio.dart';
import 'package:garage/data/models/dictionary/car_api_model.dart';
import 'package:garage/data/models/dictionary/car_model.dart';
import 'package:garage/data/models/dictionary/group_model.dart';

import '../../models/dictionary/city_model.dart';
import '../../models/dictionary/part_model.dart';

class CreateOrderParams {
  final String title;
  final CarApiModel car;
  final PartModel part;
  final String? comment;
  final List<MultipartFile> photos;
  final CityModel city;

  CreateOrderParams({
    required this.title,
    required this.car,
    required this.part,
    this.comment,
    required this.city,
    this.photos = const []
  });

  FormData toData() {
    final data = FormData.fromMap({
      'title': title,
      'car_id': car.apiId,
      'part_id': part.id,
      'city_id': city.id,
      'comment': comment
    });

    if(photos.isNotEmpty) {
      data.files.addAll(photos.map((e) {
        return MapEntry('photos[]', e);
      }) ?? []);
    }


    return data;
  }
}