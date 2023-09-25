class ProducerModel {
  final int id;
  final String name;
  final String apiId;
  final String? image;

  factory ProducerModel.fromMap(Map<String, dynamic> map) {
    return ProducerModel(
        id: map['id'],
        name: map['name'],
        apiId: map['api_id'],
        image: map['img']
    );
  }

  static List<ProducerModel> fromListMap(data) {
    return data.map<ProducerModel>((producer) {
      return ProducerModel.fromMap(producer);
    }).toList();
  }

  ProducerModel({
    required this.id,
    required this.name,
    required this.apiId,
    this.image
  });
}