part of 'auth_cubit.dart';

@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.error({required String error}) = Error;
  const factory AuthState.loginSuccess() = LoginSuccess;
  const factory AuthState.registerSuccess() = RegisterSuccess;

}
