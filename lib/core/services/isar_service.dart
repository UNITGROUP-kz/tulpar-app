import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static late Isar _isar;

  static Future initialize() async {
    final Directory dir = await getTemporaryDirectory();
    _isar = await Isar.open([
    ], directory: dir.path);
  }

  static Isar get I => _isar;
}