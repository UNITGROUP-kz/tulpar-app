import 'package:garage/data/models/dictionary/banner_model.dart';
import 'package:garage/data/models/dictionary/group_model.dart';
import 'package:garage/data/models/dictionary/part_model.dart';
import 'package:garage/data/params/car/index_car_params.dart';

import '../../../core/services/api/api_service.dart';
import '../../models/dictionary/car_api_model.dart';
import '../../models/dictionary/car_model.dart';
import '../../models/dictionary/car_model_model.dart';
import '../../models/dictionary/producer_model.dart';
import '../../params/dictionary/index_car_model_params.dart';
import '../../params/dictionary/index_group_params.dart';
import '../../params/dictionary/index_part_params.dart';
import '../../params/dictionary/index_producer_params.dart';

class DictionaryRepository {
  static Future<List<ProducerModel>> indexProducers(IndexProducerParams params) => ApiService.I
      .get('/producers', queryParameters: params.toData())
      .then((value) => ProducerModel.fromListMap(value.data['list']));

  static Future<List<GroupModel>> indexGroups(IndexGroupParams params) => ApiService.I
      .get('/part-groups', queryParameters: params.toData())
      .then((value) => GroupModel.fromListMap(value.data['list']));

  static Future<List<PartModel>> indexParts(IndexPartParams params) => ApiService.I
      .get('/parts', queryParameters: params.toData())
      .then((value) => PartModel.fromListMap(value.data['list']));

  static Future<List<CarModelModel>> indexCarModels(IndexCarModelParams params) => ApiService.I
      .get('/carModels', queryParameters: params.toData())
      .then((value) => CarModelModel.fromListMap(value.data['list']));

  static Future<List<CarApiModel>> indexCar(GetCarParams params) => ApiService.I
      .get('/car', queryParameters: params.toData())
      .then((value) => CarApiModel.fromListMap(value.data['list']));

  static Future<List<BannerModel>> indexBanner() => ApiService.I
      .get('/banners')
      .then((value) => BannerModel.fromListMap(value.data['list']));
}