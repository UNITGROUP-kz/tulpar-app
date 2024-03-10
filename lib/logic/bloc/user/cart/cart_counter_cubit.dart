import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:garage/core/services/database/isar_service.dart';
import 'package:garage/data/models/dictionary/favorite_model.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/dictionary/cart_counter_model.dart';
import '../../../../data/models/dictionary/cart_model.dart';

part 'cart_counter_state.dart';

class CartCounterCubit extends Cubit<CartCounterState> {
  CartCounterCubit() : super(CartCounterInitial()) {
    fetch();
  }
  
  Future fetch()  async {
    await IsarService.I.cartCounterModels.where().findAll().then((value) {
      emit(CartCounterSuccess(counter: value));
    });
  }

  plus(CartCounterModel counter) async {
    if(state is CartCounterSuccess) {
      final CartCounterSuccess stateSuccess = state as CartCounterSuccess;
      final CartCounterModel? oldCounter = stateSuccess.counter.firstWhereOrNull((element) => element.partId == counter.partId);
      print(oldCounter);
      if(oldCounter == null) {
        counter.count = counter.count + 1;
        await IsarService.I.writeTxn(() async {
          await IsarService.I.cartCounterModels.put(counter);
        });
        emit(CartCounterSuccess(
          counter: [
            counter,
            ...stateSuccess.counter
          ]
        ));
      } else {
        oldCounter.count = oldCounter.count + 1;
        await IsarService.I.writeTxn(() async {
          await IsarService.I.cartCounterModels.put(oldCounter);
        });
        emit(CartCounterSuccess(
          counter: stateSuccess.counter.map((e) {
              if(e.partId == oldCounter.partId) {
                return oldCounter;
              } return e;
            }).toList()
          )
        );
      }
    }
  }

  minus(CartCounterModel counter) async {
    if(counter.count == 1 ) return;
    counter.count = counter.count - 1;
    await IsarService.I.writeTxn(() async {
      await IsarService.I.cartCounterModels.put(counter);
    });
    if(state is CartCounterSuccess) {
      final CartCounterSuccess stateSuccess = state as CartCounterSuccess;
      emit(CartCounterSuccess(
          counter: stateSuccess.counter.map((e) {
            if(e.id == counter.id) {
              return counter;
            } return e;
          }).toList()
        )
      );
    }
  }

  remove(CartCounterModel counter) async {
    await IsarService.I.writeTxn(() async {
      await IsarService.I.cartCounterModels.delete(counter.id);
    });
    if(state is CartCounterSuccess) {
      final CartCounterSuccess stateSuccess = state as CartCounterSuccess;
      emit(CartCounterSuccess(
          counter: stateSuccess.counter.where((e) => e.id != counter.id).toList()
        )
      );
    }
  }

  newArray(List<CartModel> carts) async {
    await fetch();
    print(carts);
    for (var cart in carts) {
      if(state is CartCounterSuccess) {
        print(state.runtimeType);
        final CartCounterSuccess stateSuccess = state as CartCounterSuccess;
        final CartCounterModel? counter = stateSuccess.counter.firstWhereOrNull((element) => element.partId == cart.part.id);
        print(counter);

        if(counter == null) {
          plus(
              CartCounterModel()
                ..count = 0
                ..partId = cart.part.id
          );
        } else {

        }
      }
    }
  }
}
