class CarVinModel {
  final String title;
  final String carId;
  final String brand;
  final String modelName;

  CarVinModel({
    required this.title,
    required this.carId,
    required this.brand,
    required this.modelName,
  });

  factory CarVinModel.fromMap(Map<String, dynamic> map) {
    return CarVinModel(
      modelName: map['modelName'],
      title: map['title'],
      brand: map['brand'],
      carId: map['carId'],
    );
  }

  static List<CarVinModel> fromListMap(data) {
    return data.map<CarVinModel>((map) {
      return CarVinModel.fromMap(map);
    }).toList();
  }
}