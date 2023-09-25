

class PartModel {
  final int id;
  final String apiId;
  final String name;
  final String? image;


  factory PartModel.fromMap(map) {
    return PartModel(
        id: map['id'],
        name: map['name'],
        image: map['img'],
        apiId: map['api_id'],
    );
  }

  static List<PartModel> fromListMap(data) {
    // return [];
    try {
      return data.map<PartModel>((producer) {
        return PartModel.fromMap(producer);
      }).toList();
    } catch (e) {
      return [PartModel.fromMap(data)];
    }

  }

  PartModel({
    required this.id,
    required this.name,
    this.image,
    required this.apiId,
  });
}