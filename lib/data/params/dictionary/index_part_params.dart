import 'package:garage/data/models/dictionary/group_model.dart';
import 'package:garage/data/params/index.dart';

import '../../models/dictionary/car_model.dart';

enum IndexPartSortBy {
  id, name;
}

class IndexPartParams extends IndexParams {
  final IndexPartSortBy sortBy;
  final String? filter;
  final GroupModel group;

  IndexPartParams({
    super.descending,
    super.rowsPerPage,
    super.startRow,
    this.filter,
    this.sortBy = IndexPartSortBy.id,
    required this.group,
  });

  copyWith({
    int? rowsPerPage,
    int? startRow,
    bool? descending,
    String? filter,
    IndexPartSortBy? sortBy,
    GroupModel? group
  }) {
    return IndexPartParams(
        rowsPerPage: rowsPerPage ?? this.rowsPerPage,
        startRow: startRow ?? this.startRow,
        descending: descending ?? this.descending,
        filter: filter ?? this.filter,
        sortBy: sortBy ?? this.sortBy,
        group: group ?? this.group,
    );
  }

  @override
  Map<String, dynamic> toData() {
    Map<String, dynamic> data = {
      'sortBy': sortBy.name,
      'filter': filter,
      'group_id': group.id
    }..addAll(super.toData());
    print(data);
    return data;
  }
}