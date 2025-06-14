import 'package:dartz/dartz.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/features/auth/domain/entity/user_entity.dart';
import 'package:event_user/features/auth/domain/entity/user_param.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({required UserParam  param});
  Future<Either<Failure, String>> register({required UserParam2 param});

}
