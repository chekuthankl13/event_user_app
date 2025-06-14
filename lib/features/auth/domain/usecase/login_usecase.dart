import 'package:dartz/dartz.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/core/usecase/usecase.dart';
import 'package:event_user/features/auth/domain/entity/user_entity.dart';
import 'package:event_user/features/auth/domain/entity/user_param.dart';
import 'package:event_user/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase extends Usecase<UserEntity, UserParam> {
  final AuthRepository repository;

  LoginUsecase({required this.repository});
  @override
  Future<Either<Failure, UserEntity>> call(UserParam param) async {
    return await repository.login(param: param);
  }
}
