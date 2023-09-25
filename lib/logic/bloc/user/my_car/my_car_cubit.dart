import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/models/dictionary/car_model.dart';
import 'package:garage/data/models/error_model.dart';
import 'package:garage/data/params/car/index_car_params.dart';
import 'package:garage/data/repositories/user/car_user_repository.dart';

import '../auth/auth_cubit.dart';

part 'my_car_state.dart';

class MyCarCubit extends Cubit<MyCarState> {
  final AuthCubit authCubit;

  MyCarCubit(this.authCubit) : super(MyCarState());

  Future fetch([IndexMyCarParams? params]) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));
    return CarUserRepository.indexMy(params ?? IndexMyCarParams()).then((value) {
      replace(value, params ?? IndexMyCarParams());
    }).catchError((error) {
      print(error);
      if(error is DioException) {
        if(error.response?.statusCode == 403) {
          authCubit.logout();
          emit(state.copyWith(status: FetchStatus.error, error: ErrorModel.parse(error)));
        }
      }
      emit(state.copyWith(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }

  replace(List<CarModel> cars, IndexMyCarParams? params) {
    emit(state.copyWith(
      status: FetchStatus.success,
      params: params,
      cars: params == null || params.startRow == 0 ? cars : [...state.cars, ...cars]
    ));
  }
}
