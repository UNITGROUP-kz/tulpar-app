import 'package:garage/data/params/index.dart';

enum IndexOfferSortBy {
  id, name;
}

class IndexProducerParams extends IndexParams {
  final IndexOfferSortBy sortBy;
  final String? filter;

  IndexProducerParams({
    super.descending,
    super.rowsPerPage,
    super.startRow,
    this.filter,
    this.sortBy = IndexOfferSortBy.id
  });

  copyWith({
    int? rowsPerPage,
    int? startRow,
    bool? descending,
    String? filter,
    IndexOfferSortBy? sortBy
  }) {
    return IndexProducerParams(
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      startRow: startRow ?? this.startRow,
      descending: descending ?? this.descending,
      filter: filter ?? this.filter,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  @override
  Map<String, dynamic> toData() {
    return {
      'sortBy': sortBy.name,
      'filter': filter
    }..addAll(super.toData());
  }
}