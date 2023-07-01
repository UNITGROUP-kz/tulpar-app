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

}