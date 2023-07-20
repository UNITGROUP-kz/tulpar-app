import 'package:dio/dio.dart';
import 'package:garage/data/models/dictionary/car_model.dart';
import 'package:garage/data/models/dictionary/part_model.dart';

class CreateOrderParams {
  final String title;
  final CarModel car;
  final PartModel part;
  final String comment;
  final List<MultipartFile>? photos;

  CreateOrderParams({
    required this.title,
    required this.car,
    required this.part,
    required this.comment,
    this.photos
  });

  FormData toData() {
    return FormData.fromMap({
      'title': title,
      'car_id': car.id,
      'part_id': part.id,
      'comment': comment
    })..files.addAll(photos?.map((e) {
      return MapEntry('photos[]', e);
    }) ?? []);
  }
}