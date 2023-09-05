

class PartModel {
  final int id;
  final String name;
  final List<PartModel>? childs;

  factory PartModel.fromMap(map) {
    return PartModel(
        id: map['id'],
        name: map['name'],
        childs: map['childs'] != null? PartModel.fromListMap(map['childs']): null
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
    this.childs = const []
  });
}