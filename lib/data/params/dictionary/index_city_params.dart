import 'package:garage/data/params/index.dart';

enum IndexCitySortBy {
  id, name;
}

class IndexCityParams extends IndexParams {
  final IndexCitySortBy sortBy;
  final String? filter;

  IndexCityParams({
    super.descending,
    super.rowsPerPage,
    super.startRow,
    this.filter,
    this.sortBy = IndexCitySortBy.id
  });

  copyWith({
    int? rowsPerPage,
    int? startRow,
    bool? descending,
    String? filter,
    IndexCitySortBy? sortBy
  }) {
    return IndexCityParams(
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