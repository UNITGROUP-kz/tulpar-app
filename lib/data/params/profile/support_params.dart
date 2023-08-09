
import 'package:dio/dio.dart';

class SupportParams {
  final String title;
  final String description;

  SupportParams({
    required this.title,
    required this.description,
  });

  FormData toData() {
    FormData data = FormData.fromMap({
      'title': title,
      'description': description
    });

    return data;
  }

}
