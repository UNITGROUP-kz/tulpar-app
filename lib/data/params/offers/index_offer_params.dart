import 'package:garage/data/params/index.dart';

enum IndexOfferSortBy {
  id;
}

class IndexOfferParams extends IndexParams {
  final IndexOfferSortBy sortBy;

  IndexOfferParams({
    this.sortBy = IndexOfferSortBy.id,
    super.descending,
    super.rowsPerPage,
    super.startRow
  });

  @override
  toData() {
    return {
      'sortBy': sortBy.name
    }..addAll(super.toData());
  }

  IndexOfferParams copyWith({
    int? rowsPerPage,
    int? startRow,
    bool? descending,
    IndexOfferSortBy? sortBy
  }) {
    return IndexOfferParams(
      startRow: startRow ?? this.startRow,
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      descending: descending ?? this.descending,
      sortBy: sortBy ?? this.sortBy
    );
  }
}