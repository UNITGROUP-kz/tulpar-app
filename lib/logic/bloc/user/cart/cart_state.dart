part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartSuccess extends CartState {
  final List<CartModel> carts;

  CartSuccess({required this.carts});
}
