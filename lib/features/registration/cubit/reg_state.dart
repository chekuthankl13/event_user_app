part of 'reg_cubit.dart';

@freezed
sealed class RegState with _$RegState {
  const RegState._();
  const factory RegState.initial() = Initial;
  const factory RegState.loading() = Loading;
  const factory RegState.erro({required String error}) = Error;
  const factory RegState.loaded({required List<RegistrationEntity> reg}) =
      Loaded;
  const factory RegState.added() = Added;
}
