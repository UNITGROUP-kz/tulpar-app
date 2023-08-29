

class PartModel {
  final int id;
  final String name;
  final List<PartModel>? childs;

  factory PartModel.fromMap(Map<String, dynamic> map) {
    return PartModel(
        id: map['id'],
        name: map['name'],
        childs: map['childs'] != null? PartModel.fromListMap(map['childs']): null
    );
  }

  static List<PartModel> fromListMap(data) {
    return data.map<PartModel>((producer) {
      return PartModel.fromMap(producer);
    }).toList();
  }

  PartModel({
    required this.id,
    required this.name,
    this.childs = const []
  });
}