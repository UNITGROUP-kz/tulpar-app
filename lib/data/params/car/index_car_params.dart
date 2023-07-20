import 'package:garage/data/params/index.dart';

enum IndexMyCarSortBy {
  id, model_id, producer_id, vin_number, created_at, updated_at;
}

class IndexMyCarParams extends IndexParams {
  final IndexMyCarSortBy sortBy;

  IndexMyCarParams({
    super.rowsPerPage,
    super.startRow,
    super.descending,
    this.sortBy = IndexMyCarSortBy.id
  });

  @override
  toData() {
    return {
      'sortBy': sortBy.name,
    }..addAll(super.toData());
  }

  IndexMyCarParams copyWith({
      int? rowsPerPage,
      int? startRow,
      bool? descending,
      IndexMyCarSortBy? sortBy
  }) {
    return IndexMyCarParams(
        rowsPerPage: rowsPerPage ?? this.rowsPerPage,
        startRow:  startRow ?? this.startRow,
        descending: descending ?? this.descending,
        sortBy: sortBy ?? this.sortBy
    );
  }
}