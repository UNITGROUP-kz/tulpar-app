import 'package:garage/data/params/index.dart';

import '../../models/dictionary/car_api_model.dart';
import '../../models/dictionary/car_vin_model.dart';

enum IndexGroupSortBy {
  id, name;
}

class IndexGroupParams extends IndexParams {
  final IndexGroupSortBy sortBy;
  final String? filter;
  final CarApiModel? car;
  final CarVinModel? carVin;

  IndexGroupParams({
    super.descending,
    super.rowsPerPage = 1000,
    super.startRow,
    this.filter,
    this.sortBy = IndexGroupSortBy.id,
    this.car,
    this.carVin,

  });

  copyWith({
    int? rowsPerPage,
    int? startRow,
    bool? descending,
    String? filter,
    IndexGroupSortBy? sortBy,
    CarApiModel? car,
    CarVinModel? carVin
  }) {
    return IndexGroupParams(
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      startRow: startRow ?? this.startRow,
      descending: descending ?? this.descending,
      filter: filter ?? this.filter,
      sortBy: sortBy ?? this.sortBy,
      car: car ?? this.car,
      carVin: carVin ?? this.carVin
    );
  }

  @override
  Map<String, dynamic> toData() {
    Map<String, dynamic> data = {
      'sortBy': sortBy.name,
      'filter': filter,
    }..addAll(super.toData());

    if(car != null) {
      data.addAll({'carId': car!.apiId});
    } else if(carVin != null) {
      data.addAll({'carId': carVin!.carId});
    }

    print(data);
    return data;
  }
}