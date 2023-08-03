import 'package:dio/dio.dart';

class ChangeImageParams {
  final MultipartFile image;

  ChangeImageParams(this.image);

  FormData toData() {
    final data = FormData();
    data.files.add(MapEntry('image', image));
    return data;
  }
}