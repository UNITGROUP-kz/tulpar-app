import 'package:garage/data/params/index.dart';

import '../../models/dictionary/producer_model.dart';

enum IndexOfferSortBy {
  id, name;
}

class IndexCarModelParams extends IndexParams {
  final IndexOfferSortBy sortBy;
  final String? filter;
  final ProducerModel? producer;

  IndexCarModelParams({
    super.descending,
    super.rowsPerPage,
    super.startRow,
    this.filter,
    this.sortBy = IndexOfferSortBy.id,
    this.producer,
  });

  copyWith({
    int? rowsPerPage,
    int? startRow,
    bool? descending,
    String? filter,
    IndexOfferSortBy? sortBy,
    ProducerModel? producer
  }) {
    return IndexCarModelParams(
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      startRow: startRow ?? this.startRow,
      descending: descending ?? this.descending,
      filter: filter ?? this.filter,
      sortBy: sortBy ?? this.sortBy,
      producer: producer ?? this.producer
    );
  }

  @override
  Map<String, dynamic> toData() {
    return {
      'sortBy': sortBy.name,
      'filter': filter,
      'producer_id': producer?.apiId
    }..addAll(super.toData());
  }
}