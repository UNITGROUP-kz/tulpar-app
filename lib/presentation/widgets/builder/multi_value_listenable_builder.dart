import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// typedef ValueWidgetBuilder = Widget Function(BuildContext context, List<dynamic> value, Widget? child);

// extension ListExtension<E> on List<E> {
//   List<T> mapIndexed<T>(T Function(int index, E element) f) {
//     List<T> result = [];
//     for (int i = 0; i < length; i++) {
//       result.add(f(i, this[i]));
//     }
//     return result;
//   }
// }

class MultiValueListenableBuilder extends StatefulWidget {
  const MultiValueListenableBuilder({
    super.key,
    required this.valuesListenable,
    required this.builder,
    this.child,
  });

  final List<ValueListenable> valuesListenable;

  final ValueWidgetBuilder builder;

  final Widget? child;

  @override
  State<StatefulWidget> createState() => _MultiValueListenableBuilderState();
}

class _MultiValueListenableBuilderState extends State<MultiValueListenableBuilder> {
  late List<dynamic> value;

  @override
  void initState() {
    super.initState();
    _getValue();
    _addListener();
  }

  @override
  void didUpdateWidget(MultiValueListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    _removeListener();
    _getValue();
    _addListener();
  }

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  void _valueChanged() {
    setState(() { _getValue(); });
  }
  

  _getValue() {
    return value = widget.valuesListenable.map((listenable) => listenable.value).toList();
  }
  
  _addListener() {
    for (var listenable in widget.valuesListenable) {
      listenable.addListener(_valueChanged);
    }
  }

  _removeListener() {
    for (var listenable in widget.valuesListenable) {
      listenable.removeListener(_valueChanged);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, widget.child);
  }
}
