import 'package:garage/data/params/index.dart';

enum IndexPartSortBy {
  id, name;
}

class IndexPartParams extends IndexParams {
  final IndexPartSortBy sortBy;
  final String? filter;

  IndexPartParams({
    super.descending,
    super.rowsPerPage,
    super.startRow,
    this.filter,
    this.sortBy = IndexPartSortBy.id
  });

  copyWith({
    int? rowsPerPage,
    int? startRow,
    bool? descending,
    String? filter,
    IndexPartSortBy? sortBy
  }) {
    return IndexPartParams(
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      startRow: startRow ?? this.startRow,
      descending: descending ?? this.descending,
      filter: filter ?? this.filter,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  @override
  Map<String, dynamic> toData() {
    Map<String, dynamic> data = {
      'sortBy': sortBy.name,
      'filter': filter
    }..addAll(super.toData());
    print(data);
    return data;
  }
}