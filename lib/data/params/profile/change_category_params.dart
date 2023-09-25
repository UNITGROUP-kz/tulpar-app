
import 'package:dio/dio.dart';

class ChangeCategoryParams {
  final List<int> producers;
  final List<int> models;
  final List<int> groups;

  ChangeCategoryParams({
    required this.producers,
    required this.models,
    required this.groups,
  });

  FormData toData() {
    FormData data = FormData.fromMap({
      'producers[]': producers,
      'models[]': models,
      'groups[]': groups
    });
    print(data.fields);

    return data;
  }

}
