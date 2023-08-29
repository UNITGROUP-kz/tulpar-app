
import 'package:dio/dio.dart';

class ChangeCategoryParams {
  final List<int> producers;
  final List<int> models;
  final List<int> parts;

  ChangeCategoryParams({
    required this.producers,
    required this.models,
    required this.parts,
  });

  FormData toData() {
    FormData data = FormData.fromMap({
      'producers[]': producers,
      'models[]': models,
      'parts[]': parts
    });
    print(data.fields);

    return data;
  }

}
