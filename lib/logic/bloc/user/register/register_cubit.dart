import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/models/error_model.dart';
import 'package:garage/data/params/auth/auth_user_params.dart';

import '../../../../core/utils/check.dart';
import '../../../../data/repositories/user/auth_user_repository.dart';
import '../auth/auth_cubit.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthCubit authCubit;
  
  RegisterCubit(this.authCubit) : super(RegisterState()) {
    authCubit.stream.listen(_listenerRegister);
  }
  
  _listenerRegister(AuthState stateAuth) {
    if(stateAuth.auth == null) {
      emit(state.copyWith(status: RegisterStatusState.register));
    } else {
      emit(state.copyWith(status: RegisterStatusState.success));
    }
  }
  
  
  register(String name, String emailPhone, String password, String confirmPassword) async {
    if(state.isLoading) return;
    emit(RegisterState(isLoading: true));

    await AuthUserRepository.register(RegisterUserParams(
        name: name,
        password: password,
        passwordConfirmation: confirmPassword,
        email: Check.isEmail(emailPhone) ? emailPhone : null,
        phone: Check.isPhone(emailPhone) ? emailPhone : null,
        type: Check.isEmail(emailPhone)? AuthorizationRequestType.email: AuthorizationRequestType.phone,
    )).then((value) {
      toVerify();
    }).catchError((error) {
      emit(state.copyWith(isLoading: false, error: ErrorModel.parse(error)));
    });
  }


  verify(String emailPhone, String code) async {
    if(state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    await AuthUserRepository.code(ConfirmUserParams(
      email: Check.isEmail(emailPhone) ? emailPhone : null,
      phone: Check.isPhone(emailPhone) ? emailPhone : null,
      code: code,
    )).then((value) {
      authCubit.set(value);
      emit(state.copyWith(isLoading: false, status: RegisterStatusState.success));
    }).catchError((error) {
      print(error);
      emit(state.copyWith(isLoading: false, error: ErrorModel.parse(error)));
    });
  }

  toVerify() {
    emit(state.copyWith(isLoading: false, status: RegisterStatusState.verify));
  }
}
