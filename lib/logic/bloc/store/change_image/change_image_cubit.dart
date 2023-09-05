import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/params/profile/change_profile_params.dart';

import '../../../../data/models/error_model.dart';
import '../../../../data/params/change_image_params.dart';
import '../../../../data/repositories/store/auth_store_repository.dart';
import '../auth/auth_store_cubit.dart';

part 'change_image_state.dart';

class ChangeImageStoreCubit extends Cubit<ChangeImageStoreState> {
  final AuthStoreCubit authStoreCubit;

  ChangeImageStoreCubit(this.authStoreCubit) : super(ChangeImageStoreState());


  change(ChangeImageParams params, Uint8List bytes) async {
    if(state.status == FetchStatus.loading) return;
    emit(ChangeImageStoreState(status: FetchStatus.loading, bytes: bytes));
    await AuthStoreRepository.changeImage(params).then((value) async {
      authStoreCubit.set(value);
      emit(ChangeImageStoreState(status: FetchStatus.success));
    }).catchError((error) {
      if(error is DioException) {
        if(error.response?.statusCode == 403) {
          authStoreCubit.logout();
          emit(ChangeImageStoreState(status: FetchStatus.error, error: ErrorModel.parse(error)));
        }
      }
      emit(ChangeImageStoreState(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }

}
