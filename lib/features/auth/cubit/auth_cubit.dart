import 'package:event_user/features/auth/data/model/user_param_model.dart';
import 'package:event_user/features/auth/domain/usecase/login_usecase.dart';
import 'package:event_user/features/auth/domain/usecase/register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  AuthCubit(this.loginUsecase, this.registerUsecase)
    : super(AuthState.initial());

  login({email, password}) async {
    try {
      emit(AuthState.loading());
      var res = await loginUsecase(
        UserParamModel(email: email, password: password),
      );
      res.fold(
        (l) => emit(AuthState.error(error: l.error)),
        (r) => emit(AuthState.loginSuccess()),
      );
    } catch (e) {
      emit(AuthState.error(error: e.toString()));
    }
  }

  register({email, password, phone, name}) async {
    try {
      emit(AuthState.loading());
      var res = await registerUsecase(
        UserParamModel2(
          email: email,
          password: password,
          name: name,
          phone: phone,
        ),
      );
      res.fold(
        (l) => emit(AuthState.error(error: l.error)),
        (r) => emit(AuthState.registerSuccess()),
      );
    } catch (e) {
      emit(AuthState.error(error: e.toString()));
    }
  }
}
