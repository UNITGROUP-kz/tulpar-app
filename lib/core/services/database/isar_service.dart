import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/auth/auth_model.dart';
import '../../../data/models/auth/auth_store_model.dart';
import '../../../data/models/auth/store_model.dart';
import '../../../data/models/auth/user_model.dart';
import '../../../data/models/dictionary/city_model.dart';

class IsarService {
  static late Isar _isar;

  static Future initialize() async {
    final Directory dir = await getTemporaryDirectory();
    _isar = await Isar.open([
      AuthModelSchema,
      UserModelSchema,
      AuthStoreModelSchema,
      StoreModelSchema,
      CityModelSchema,
    ], directory: dir.path);
  }

  static Isar get I => _isar;
}