import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/params/profile/change_profile_params.dart';
import 'package:garage/data/repositories/user/auth_user_repository.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/error_model.dart';
import '../../../../data/params/store/change_store_params.dart';
import '../../../../data/repositories/store/auth_store_repository.dart';
import '../auth/auth_store_cubit.dart';

part 'change_store_state.dart';

class ChangeStoreCubit extends Cubit<ChangeStoreState> {
  final AuthStoreCubit authCubit;
  ChangeStoreCubit(this.authCubit) : super(ChangeStoreState());


  change(ChangeStoreParams params) {
    if(state.status == FetchStatus.loading) return;
    emit(ChangeStoreState(status: FetchStatus.loading));
    AuthStoreRepository.update(params).then((value) {
      authCubit.set(value);
      emit(ChangeStoreState(status: FetchStatus.success));
    }).catchError((error) {
      print(error);
      emit(ChangeStoreState(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }
}
