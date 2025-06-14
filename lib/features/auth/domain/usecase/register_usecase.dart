import 'package:dartz/dartz.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/core/usecase/usecase.dart';
import 'package:event_user/features/auth/domain/entity/user_param.dart';
import 'package:event_user/features/auth/domain/repository/auth_repository.dart';

class RegisterUsecase extends Usecase<String, UserParam2> {
  final AuthRepository repository;

  RegisterUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(UserParam2 param) async {
    return await repository.register(param: param);
  }
}
