import 'package:dio/dio.dart';

class EditStoreParams {
  final String? name;
  final String? description;

  EditStoreParams({
    required this.name,
    required this.description
  });

  toData() {
    return {
      'name': name,
      'description': description
    };
  }
}

class EditImageStoreParams {
  final MultipartFile image;

  EditImageStoreParams(this.image);

  FormData toData() {
    return FormData()..files.add(MapEntry('image', image));
  }
}