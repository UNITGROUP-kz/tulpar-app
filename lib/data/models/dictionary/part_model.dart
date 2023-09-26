

class PartModel {
  final int id;
  final String name;
  final String number;
  final String? notice;
  final String? description;


  factory PartModel.fromMap(map) {
    return PartModel(
        id: map['id'],
        name: map['name'],
        number: map['number'],
        notice: map['notice'],
        description: map['description'],
    );
  }

  static List<PartModel> fromListMap(data) {
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
    required this.number,
    this.notice,
    this.description,
  });
}