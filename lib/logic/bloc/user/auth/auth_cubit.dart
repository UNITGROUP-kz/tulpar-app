import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/models/auth/auth_model.dart';
import 'package:garage/data/models/auth/user_model.dart';
import '../../../../data/repositories/user/auth_user_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  initial() async {
    AuthModel? auth = await AuthUserRepository.read();
    if(auth == null) return;

    print('User: ${auth.token}');
    set(auth);
  }

  logout() async {
    await AuthUserRepository.clear().then((value) {
      emit(const AuthState());
    });
  }

  Future delete() async {
    return await AuthUserRepository.deleteProfile().then((value) {
      emit(const AuthState());
    });
  }

  set(AuthModel auth) {
    emit(state.copyWith(auth: auth));
  }

  bool get isLogin => state.auth != null;
}
