
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/logic/bloc/store/auth/auth_store_cubit.dart';

import '../../../../data/models/error_model.dart';
import '../../../../data/params/auth/auth_store_params.dart';
import '../../../../data/repositories/store/auth_store_repository.dart';

part 'login_store_state.dart';

class LoginStoreCubit extends Cubit<LoginStoreState> {
  final AuthStoreCubit authCubit;

  LoginStoreCubit(this.authCubit) : super(LoginStoreState());


  login(String phone, String password) async {
    if(state.status == FetchStatus.loading) return;

    emit(LoginStoreState(status: FetchStatus.loading));

    await AuthStoreRepository.login(LoginStoreParams(
        password: password,
        phone: phone
    )).then((value) {
      authCubit.set(value);
      emit(LoginStoreState(status: FetchStatus.success));
    }).catchError((error) {
      print(error);
      emit(LoginStoreState(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }
}
