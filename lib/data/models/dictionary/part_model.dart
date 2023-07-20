class PartModel {
  final int id;
  final String name;

  factory PartModel.fromMap(Map<String, dynamic> map) {
    return PartModel(
        id: map['id'],
        name: map['name']
    );
  }

  static List<PartModel> fromListMap(data) {
    return data.map<PartModel>((producer) {
      return PartModel.fromMap(producer);
    }).toList();
  }

  PartModel({
    required this.id,
    required this.name
  });
}