

class OfferModel {
  final int id;

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
      id: map['id'],
    );
  }

  static List<OfferModel> fromListMap(data) {
    return data.map<OfferModel>((map) {
      return OfferModel.fromMap(map);
    }).toList();
  }

  OfferModel({
    required this.id,
  });
}