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
}