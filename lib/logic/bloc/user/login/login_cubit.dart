import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/check.dart';
import '../../../../data/models/error_model.dart';
import '../../../../data/params/auth/auth_user_params.dart';
import '../../../../data/repositories/user/auth_user_repository.dart';
import '../auth/auth_cubit.dart';
import '../register/register_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthCubit authCubit;
  final RegisterCubit registerCubit;
  LoginCubit(this.authCubit, this.registerCubit) : super(LoginState());


  login(String emailPhone, String password) async {
    if(state.status == LoginStatus.loading) return;
    emit(state.copyWith(status: LoginStatus.loading));

    await AuthUserRepository.login(LoginUserParams(
        password: password,
        email: Check.isEmail(emailPhone) ? emailPhone : null,
        phone: Check.isPhone(emailPhone) ? emailPhone : null
    )).then((value) {
      authCubit.set(value);
    }).catchError((error) {
      if(error is DioException) {
        if(error.response?.statusCode == 406) {
          registerCubit.toVerify();
          emit(state.copyWith(status: LoginStatus.validate, error: ErrorModel.parse(error)));
        }
      }
      emit(state.copyWith(status: LoginStatus.error, error: ErrorModel.parse(error)));
    });
  }

}
