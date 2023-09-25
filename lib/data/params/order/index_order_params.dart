import 'package:garage/data/models/dictionary/group_model.dart';
import 'package:garage/data/params/index.dart';

import '../../models/dictionary/car_model_model.dart';
import '../../models/dictionary/order_model.dart';
import '../../models/dictionary/producer_model.dart';

enum IndexOrderSortBy {
  id;
}

class IndexOrderParams extends IndexParams {
  final IndexOrderSortBy sortBy;
  final CarModelModel? model;
  final GroupModel? group;
  final ProducerModel? producer;
  final String? vin;
  final OrderStatus? status;
  final double? lat;
  final double? lon;
  final int radius;

  IndexOrderParams( {
    this.sortBy = IndexOrderSortBy.id,
    this.model,
    this.group,
    this.producer,
    this.vin,
    this.status,
    super.descending,
    super.rowsPerPage,
    super.startRow,
    this.lat,
    this.lon,
    this.radius = 20
  });

  @override
  toData() {
    Map<String, dynamic> data = {
      'sortBy': sortBy.name,
      'lat': lat,
      'lon': lon,
      'radius': radius
    }..addAll(super.toData());
    //'model_id': model?.id,
    //       'producer_id': producer?.id,
    //       'group_id': group?.id,
    //       'vin': vin,
    //       'status': status?.name

    print(data);

    return data;
  }

  IndexOrderParams copyWith({
    int? rowsPerPage,
    int? startRow,
    bool? descending,
    OrderStatus? status,
    String? vin,
    ProducerModel? producer,
    GroupModel? group,
    CarModelModel? model,
    IndexOrderSortBy? sortBy,
    double? lat,
    double? lon,
    int? radius
  }) {
    return IndexOrderParams(
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      startRow: startRow ?? this.startRow,
      descending: descending ?? this.descending,
      status: status ?? this.status,
      vin: vin ?? this.vin,
      producer: producer ?? this.producer,
      group: group ?? this.group,
      model: model ?? this.model,
      sortBy: sortBy ?? this.sortBy,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      radius: radius ?? this.radius
    );
  }
}