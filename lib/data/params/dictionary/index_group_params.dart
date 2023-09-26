import 'package:garage/data/params/index.dart';

import '../../models/dictionary/car_api_model.dart';
import '../../models/dictionary/car_model.dart';

enum IndexGroupSortBy {
  id, name;
}

class IndexGroupParams extends IndexParams {
  final IndexGroupSortBy sortBy;
  final String? filter;
  final CarApiModel car;

  IndexGroupParams({
    super.descending,
    super.rowsPerPage,
    super.startRow,
    this.filter,
    this.sortBy = IndexGroupSortBy.id,
    required this.car,
  });

  copyWith({
    int? rowsPerPage,
    int? startRow,
    bool? descending,
    String? filter,
    IndexGroupSortBy? sortBy,
    CarApiModel? car
  }) {
    return IndexGroupParams(
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      startRow: startRow ?? this.startRow,
      descending: descending ?? this.descending,
      filter: filter ?? this.filter,
      sortBy: sortBy ?? this.sortBy,
      car: car ?? this.car
    );
  }

  @override
  Map<String, dynamic> toData() {
    Map<String, dynamic> data = {
      'sortBy': sortBy.name,
      'filter': filter,
      'car_id': car.apiId
    }..addAll(super.toData());
    print(data);
    return data;
  }
}