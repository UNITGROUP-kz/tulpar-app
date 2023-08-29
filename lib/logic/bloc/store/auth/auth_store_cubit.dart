import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/models/auth/auth_store_model.dart';
import 'package:garage/data/models/auth/store_model.dart';

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

  fetchInfo() async {
    AuthStoreRepository.info().then((value) {
      emit(AuthStoreState(auth: value));
    }).catchError((error) {
      logout();
    });

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
