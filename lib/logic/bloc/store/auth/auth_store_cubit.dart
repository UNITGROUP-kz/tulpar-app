import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/models/auth/auth_store_model.dart';
import 'package:garage/data/models/auth/store_model.dart';

import '../../../../data/models/auth/auth_model.dart';
import '../../../../data/models/auth/user_model.dart';
import '../../../../data/models/error_model.dart';
import '../../../../data/params/auth/auth_store_params.dart';
import '../../../../data/repositories/store/auth_store_repository.dart';

part 'auth_store_state.dart';

class AuthStoreCubit extends Cubit<AuthStoreState> {
  AuthStoreCubit() : super(AuthStoreState());


  initial() async {
    AuthStoreModel? auth = await AuthStoreRepository.read();
    if(auth != null) {
      print(auth.token);
      emit(AuthStoreState(auth: auth));
    }
  }

  login(String phone, String password) async {
    if(state.isLoading) return;
    emit(AuthStoreState(isLoading: true));

    await AuthStoreRepository.login(LoginStoreParams(
        password: password,
        phone: phone
    )).then((value) {
      set(value);
    }).catchError((error) {
      print(error);
      emit(AuthStoreState(isLoading: false, error: ErrorModel.parse(error)));
    });
  }

  logout() async {
    await AuthStoreRepository.clear().then((value) {
      emit(AuthStoreState());
    });
  }

  set(AuthStoreModel auth) {
    emit(AuthStoreState(auth: auth, isLoading: false));
  }

  bool get isLogin => state.auth != null;
}
