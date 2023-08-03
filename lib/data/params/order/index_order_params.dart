import 'package:garage/data/models/dictionary/part_model.dart';
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
  final PartModel? part;
  final ProducerModel? producer;
  final String? vin;
  final OrderStatus? status;

  IndexOrderParams({
    this.sortBy = IndexOrderSortBy.id,
    this.model,
    this.part,
    this.producer,
    this.vin,
    this.status,
    super.descending,
    super.rowsPerPage,
    super.startRow
  });

  @override
  toData() {
    Map<String, dynamic> data = {
      'sortBy': sortBy.name,

    }..addAll(super.toData());
    //'model_id': model?.id,
    //       'producer_id': producer?.id,
    //       'part_id': part?.id,
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
    PartModel? part,
    CarModelModel? model,
    IndexOrderSortBy? sortBy
  }) {
    return IndexOrderParams(
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      startRow: startRow ?? this.startRow,
      descending: descending ?? this.descending,
      status: status ?? this.status,
      vin: vin ?? this.vin,
      producer: producer ?? this.producer,
      part: part ?? this.part,
      model: model ?? this.model,
      sortBy: sortBy ?? this.sortBy,

    );
  }
}