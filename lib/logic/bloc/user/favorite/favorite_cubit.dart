import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/models/dictionary/favorite_model.dart';
import 'package:isar/isar.dart';

import '../../../../core/services/database/isar_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteState());


  fetch() {
    IsarService.I.favoriteModels.where().findAll().then((value) {
      emit(FavoriteState(favorites: value));
    });
  }

  toggle(int carId) async{
    final isHave = state.favorites.any((element) => element.carId == carId);

    if(isHave) {
      _delete(carId);
    } else {
      _add(carId);
    }
  }

  _delete(int carId) async {
    FavoriteModel favorite = (await IsarService.I.favoriteModels.filter().carIdEqualTo(carId).findAll())[0];
    await IsarService.I.writeTxn(() async {
      await IsarService.I.favoriteModels.delete(favorite.id);
    });
    emit(state.copyWith(favorites: state.favorites.where((element) => element.id != favorite.id).toList()));
  }

  _add(int carId) async {
    FavoriteModel favorite = FavoriteModel()..carId = carId;
    await IsarService.I.writeTxn(() async {
      await IsarService.I.favoriteModels.put(favorite);
    });
    emit(state.copyWith(favorites: [...state.favorites, favorite]));
  }
}
