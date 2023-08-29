extension ListMap<T> on List<T> {
  List<R> mapWithIndex<R>(R Function(T, int) callback) {
    List<R> list = [];
    for(var i = 0; i < length; i++) {
      list.add(callback(this[i], i));
    }
    return list;
  }
}