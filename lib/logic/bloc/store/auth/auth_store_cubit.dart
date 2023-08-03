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
    if(auth == null) return;
    print('Store: ${auth.token}');

    emit(AuthStoreState(auth: auth));
  }


  logout() async {
    await AuthStoreRepository.clear().then((value) {
      emit(AuthStoreState());
    });
  }

  set(AuthStoreModel auth) {
    emit(AuthStoreState(auth: auth));
  }

  bool get isLogin => state.auth != null;
}
