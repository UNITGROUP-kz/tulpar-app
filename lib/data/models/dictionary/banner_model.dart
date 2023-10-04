import 'package:flutter/cupertino.dart';

import '../auth/store_model.dart';

class BannerModel {
  final int id;
  final String image;
  final StoreModel store;

  BannerModel({
    required this.id,
    required this.image,
    required this.store
  });

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'],
      image: map['image'],
      store: StoreModel.fromMap(map['store'])
    );
  }

  static List<BannerModel> fromListMap(data) {
    return data.map<BannerModel>((map) {
      return BannerModel.fromMap(map);
    }).toList();
  }

}