import 'package:dartz/dartz.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/core/usecase/usecase.dart';
import 'package:event_user/features/registration/domain/entity/registration_param.dart';
import 'package:event_user/features/registration/domain/repository/registration_repository.dart';

class RegisterUsecase extends Usecase<String, RegistrationParam> {
  final RegistrationRepository repository;

  RegisterUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(RegistrationParam param) async {
    return await repository.add(param: param);
  }
}
