import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/params/profile/support_params.dart';
import 'package:garage/data/repositories/support_repository.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/error_model.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit() : super(SupportState());

  create(SupportParams params) {
    if(state.status == FetchStatus.loading) return;
    emit(SupportState(status: FetchStatus.loading));
    SupportRepository.support(params).then((value) {
      emit(SupportState(status: FetchStatus.success));
    }).catchError((error) {
      print(error);
      emit(SupportState(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }
}
