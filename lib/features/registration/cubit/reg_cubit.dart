import 'package:event_user/core/usecase/usecase.dart';
import 'package:event_user/features/registration/data/model/registration_param_model.dart';
import 'package:event_user/features/registration/domain/entity/registration_entity.dart';
import 'package:event_user/features/registration/domain/usecase/load_registration_usecase.dart';
import 'package:event_user/features/registration/domain/usecase/register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reg_state.dart';
part 'reg_cubit.freezed.dart';

class RegCubit extends Cubit<RegState> {
  final LoadRegistrationUsecase loadRegistrationUsecase;
  final RegisterUsecase registerUsecase;
  RegCubit(this.loadRegistrationUsecase, this.registerUsecase)
    : super(RegState.initial());

  load() async {
    try {
      emit(RegState.loading());
      var res = await loadRegistrationUsecase(NoParam());
      res.fold(
        (l) => emit(RegState.erro(error: l.error)),
        (r) => emit(RegState.loaded(reg: r)),
      );
    } catch (e) {
      emit(RegState.erro(error: e.toString()));
    }
  }

  add({email, eventId, name, phone}) async {
    try {
      emit(RegState.loading());
      var res = await registerUsecase(
        RegistrationParamModel(
          email: email,
          eventId: eventId,
          name: name,
          phone: phone,
        ),
      );
      res.fold(
        (l) => emit(RegState.erro(error: l.error)),
        (r) => emit(RegState.added()),
      );
    } catch (e) {
      emit(RegState.erro(error: e.toString()));
    }
  }
}
