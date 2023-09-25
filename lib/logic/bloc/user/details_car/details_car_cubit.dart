import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/models/dictionary/group_model.dart';
import 'package:garage/data/repositories/dictionary/dictionary_repository.dart';

import '../../../../data/models/error_model.dart';
import '../../../../data/params/dictionary/index_group_params.dart';
import '../auth/auth_cubit.dart';

part 'details_car_state.dart';

class DetailsCarCubit extends Cubit<DetailsCarState> {
  final AuthCubit authCubit;
  DetailsCarCubit(this.authCubit) : super(DetailsCarState());

  Future fetch(IndexGroupParams params) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));

    print('params: ${params?.toData()}');
    return DictionaryRepository.indexGroups(params).then((value) {
      print(value);
      replace(value, params);
    }).catchError((error) {
      if(error is DioException) {
        if(error.response?.statusCode == 403) {
          authCubit.logout();
          emit(state.copyWith(status: FetchStatus.error, error: ErrorModel.parse(error)));
        }
      }
      emit(state.copyWith(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }

  replace(List<GroupModel> groups, IndexGroupParams? params) {
    emit(state.copyWith(
        status: FetchStatus.success,
        params: params,
        groups: params == null || params.startRow == 0 ? groups : [...state.groups, ...groups]
    ));
  }
}
