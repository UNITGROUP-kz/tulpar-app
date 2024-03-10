

class GroupModel {
  final int id;
  final String apiId;
  final String name;
  final List<GroupModel>? childs;
  final String? image;
  final bool hasGroups;
  final bool hasParts;

  factory GroupModel.fromMap(map) {
    return GroupModel(
        id: map['id'],
        name: map['name'],
        image: map['img'],
        childs: map['childs'] != null? GroupModel.fromListMap(map['childs']): null,
        apiId: map['api_id'],
        hasParts: map['hasParts'],
        hasGroups: map['hasGroups']
    );
  }

  static List<GroupModel> fromListMap(data) {
    // return [];
    try {
      return data.map<GroupModel>((producer) {
        return GroupModel.fromMap(producer);
      }).toList();
    } catch (e) {
      return [GroupModel.fromMap(data)];
    }

  }

  GroupModel({
    required this.id,
    required this.name,
    this.childs = const [],
    this.image,
    required this.apiId,
    required this.hasGroups,
    required this.hasParts,
  });
}