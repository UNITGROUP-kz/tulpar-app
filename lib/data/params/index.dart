
abstract class IndexParams {
  final int rowsPerPage;
  final int startRow;
  final bool descending;

  IndexParams({
    this.rowsPerPage = 20,
    this.startRow = 0,
    this.descending = false
  });

  Map<String, dynamic> toData() {
    return {
      'rowsPerPage': rowsPerPage,
      'startRow': startRow,
      'descending': descending ? 1 : 0
    };
  }
}