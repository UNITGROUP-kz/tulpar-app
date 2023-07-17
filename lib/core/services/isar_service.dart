import 'dart:io';

import 'package:garage/data/models/auth/auth_model.dart';
import 'package:garage/data/models/auth/user_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static late Isar _isar;

  static Future initialize() async {
    final Directory dir = await getTemporaryDirectory();
    _isar = await Isar.open([
      AuthModelSchema,
      UserModelSchema
    ], directory: dir.path);
  }

  static Isar get I => _isar;
}