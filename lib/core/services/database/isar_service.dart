import 'dart:io';

import 'package:garage/data/models/dictionary/car_model_model.dart';
import 'package:garage/data/models/dictionary/group_model.dart';
import 'package:garage/data/models/dictionary/producer_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/auth/auth_model.dart';
import '../../../data/models/auth/auth_store_model.dart';
import '../../../data/models/auth/store_model.dart';
import '../../../data/models/auth/user_model.dart';
import '../../../data/models/dictionary/city_model.dart';
import '../../../data/models/dictionary/favorite_model.dart';

class IsarService {
  static late Isar _isar;

  static Future initialize() async {
    final Directory dir = await getTemporaryDirectory();
    _isar = await Isar.open([
      //AUTH
      AuthModelSchema,
      AuthStoreModelSchema,

      //USER AND STORE
      UserModelSchema,
      StoreModelSchema,

      //DICTIONARY
      CityModelSchema,
      FavoriteModelSchema,


    ], directory: dir.path);
  }

  static Isar get I => _isar;
}