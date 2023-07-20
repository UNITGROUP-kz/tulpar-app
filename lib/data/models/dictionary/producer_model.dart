class ProducerModel {
  final int id;
  final String name;

  factory ProducerModel.fromMap(Map<String, dynamic> map) {
    return ProducerModel(
        id: map['id'],
        name: map['name']
    );
  }

  static List<ProducerModel> fromListMap(data) {
    return data.map<ProducerModel>((producer) {
      return ProducerModel.fromMap(producer);
    }).toList();
  }

  ProducerModel({
    required this.id,
    required this.name
  });
}