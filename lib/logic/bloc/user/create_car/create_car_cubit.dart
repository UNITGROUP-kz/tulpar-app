import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/models/error_model.dart';
import 'package:garage/data/params/car/create_car_params.dart';
import 'package:garage/data/repositories/user/car_user_repository.dart';

import '../auth/auth_cubit.dart';
import '../my_car/my_car_cubit.dart';

part 'create_car_state.dart';

class CreateCarCubit extends Cubit<CreateCarState> {
  final MyCarCubit myCarCubit;
  final AuthCubit authCubit;
  CreateCarCubit(this.myCarCubit, this.authCubit) : super(CreateCarState());

  create(CreateCarParams params) {
    if(state.status == FetchStatus.loading) return;
    emit(CreateCarState(status: FetchStatus.loading));
    CarUserRepository.create(params).then((value) {
      myCarCubit.fetch();
      emit(CreateCarState(status: FetchStatus.success));
    }).catchError((error) {
      print(error);
      if(error is DioException) {
        if(error.response?.statusCode == 403) {
          authCubit.logout();
          emit(CreateCarState(status: FetchStatus.error, error: ErrorModel.parse(error)));
        }
      }
      emit(CreateCarState(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }
}
