part of 'cart_counter_cubit.dart';

@immutable
abstract class CartCounterState {}

class CartCounterInitial extends CartCounterState {}

class CartCounterSuccess extends CartCounterState {
  final List<CartCounterModel> counter;

  CartCounterSuccess({required this.counter});
}

