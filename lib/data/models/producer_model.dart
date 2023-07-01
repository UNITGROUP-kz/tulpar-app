class ProducerModel {
  final int id;
  final String name;

  factory ProducerModel.fromMap(Map<String, dynamic> map) {
    return ProducerModel(
        id: map['id'],
        name: map['name']
    );
  }

  ProducerModel({
    required this.id,
    required this.name
  });
}