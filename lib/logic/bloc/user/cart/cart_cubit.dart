import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:garage/data/models/dictionary/cart_counter_model.dart';
import 'package:garage/data/models/dictionary/group_model.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/dictionary/cart_model.dart';
import '../../../../data/repositories/user/cart_repository.dart';
import 'cart_counter_cubit.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartCounterCubit counterCubit;
  CartCubit(this.counterCubit) : super(CartInitial()) {
    fetch();
  }

  Future fetch() async {
    try {
      final List<CartModel> carts = await CartRepository.fetch();
      emit(CartSuccess(carts: carts));
      await counterCubit.newArray(carts);
      return carts;
    } catch(err) {
      rethrow;
    }
  }

  Future add(int id) async {
    if(state is CartSuccess) {
      final CartSuccess success = state as CartSuccess;
      if(success.carts.firstWhereOrNull((val) => val.part.id == id) != null) return;
      print('AAAAAA');
    }
    try {
      await CartRepository.add(id);
      counterCubit.plus(CartCounterModel()..count = 0..partId = id);
      await fetch();
    } catch(err) {
      rethrow;
    }
  }

  Future delete(GroupModel group) async {
    try {
      await CartRepository.delete(group.id);
      await fetch();
    } catch(err) {
      rethrow;
    }
  }
}
