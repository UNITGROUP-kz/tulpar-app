import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/params/profile/change_profile_params.dart';
import 'package:garage/data/repositories/user/auth_user_repository.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/error_model.dart';
import '../auth/auth_cubit.dart';

part 'change_profile_state.dart';

class ChangeProfileCubit extends Cubit<ChangeProfileState> {
  final AuthCubit authCubit;
  ChangeProfileCubit(this.authCubit) : super(ChangeProfileState());


  change(ChangeProfileParams params) async {
    if(state.status == FetchStatus.loading) return;
    emit(ChangeProfileState(status: FetchStatus.loading));
    await AuthUserRepository.update(params).then((value) async {
      authCubit.set(value);
      emit(ChangeProfileState(status: FetchStatus.success));
    }).catchError((error) {
      emit(ChangeProfileState(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }

}
