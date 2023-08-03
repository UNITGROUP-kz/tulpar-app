import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/params/profile/change_profile_params.dart';

import '../../../../data/models/error_model.dart';
import '../../../../data/params/change_image_params.dart';
import '../../../../data/repositories/user/auth_user_repository.dart';
import '../auth/auth_cubit.dart';

part 'change_image_state.dart';

class ChangeImageUserCubit extends Cubit<ChangeImageUserState> {
  final AuthCubit authCubit;

  ChangeImageUserCubit(this.authCubit) : super(ChangeImageUserState());


  change(ChangeImageParams params, Uint8List bytes) async {
    if(state.status == FetchStatus.loading) return;
    emit(ChangeImageUserState(status: FetchStatus.loading, bytes: bytes));
    await AuthUserRepository.changeImage(params).then((value) async {
      authCubit.set(value);
      emit(ChangeImageUserState(status: FetchStatus.success));
    }).catchError((error) {
      emit(ChangeImageUserState(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }

}
