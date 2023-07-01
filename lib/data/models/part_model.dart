class PartModel {
  final int id;
  final String name;

  factory PartModel.fromMap(Map<String, dynamic> map) {
    return PartModel(
        id: map['id'],
        name: map['name']
    );
  }

  PartModel({
    required this.id,
    required this.name
  });
}