import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/models/auth/auth_model.dart';
import 'package:garage/data/models/auth/user_model.dart';

import '../../../../core/utils/check.dart';
import '../../../../data/params/auth/auth_user_params.dart';
import '../../../../data/repositories/user/auth_user_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());


  initial() async {
    AuthModel? auth = await AuthUserRepository.read();
    if(auth != null) {
      print(auth.token);
      emit(AuthState(auth: auth));
    }
  }

  login(String emailPhone, String password) async {
    if(state.isLoading) return;
    emit(AuthState(isLoading: true));

    await AuthUserRepository.login(LoginUserParams(
        password: password,
        email: Check.isEmail(emailPhone) ? emailPhone : null,
        phone: Check.isPhone(emailPhone) ? emailPhone : null
    )).then((value) {
      emit(AuthState(isLoading: false, auth: value));
    }).catchError((error) {
      print(error);
      emit(AuthState(isLoading: false));
    });
  }

  logout() async {
    await AuthUserRepository.clear().then((value) {
      emit(AuthState());
    });
  }
}
