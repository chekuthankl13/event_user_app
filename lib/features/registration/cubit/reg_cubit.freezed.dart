// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reg_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegState()';
}


}

/// @nodoc
class $RegStateCopyWith<$Res>  {
$RegStateCopyWith(RegState _, $Res Function(RegState) __);
}


/// @nodoc


class Initial extends RegState {
  const Initial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegState.initial()';
}


}




/// @nodoc


class Loading extends RegState {
  const Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegState.loading()';
}


}




/// @nodoc


class Error extends RegState {
  const Error({required this.error}): super._();
  

 final  String error;

/// Create a copy of RegState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'RegState.erro(error: $error)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $RegStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of RegState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(Error(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Loaded extends RegState {
  const Loaded({required final  List<RegistrationEntity> reg}): _reg = reg,super._();
  

 final  List<RegistrationEntity> _reg;
 List<RegistrationEntity> get reg {
  if (_reg is EqualUnmodifiableListView) return _reg;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reg);
}


/// Create a copy of RegState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._reg, _reg));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reg));

@override
String toString() {
  return 'RegState.loaded(reg: $reg)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $RegStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<RegistrationEntity> reg
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of RegState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reg = null,}) {
  return _then(Loaded(
reg: null == reg ? _self._reg : reg // ignore: cast_nullable_to_non_nullable
as List<RegistrationEntity>,
  ));
}


}

/// @nodoc


class Added extends RegState {
  const Added(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Added);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegState.added()';
}


}




// dart format on
