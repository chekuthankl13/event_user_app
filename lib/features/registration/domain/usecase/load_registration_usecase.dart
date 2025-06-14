import 'package:dartz/dartz.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/core/usecase/usecase.dart';
import 'package:event_user/features/registration/domain/entity/registration_entity.dart';
import 'package:event_user/features/registration/domain/repository/registration_repository.dart';

class LoadRegistrationUsecase
    extends Usecase<List<RegistrationEntity>, NoParam> {
  final RegistrationRepository repository;

  LoadRegistrationUsecase({required this.repository});
  @override
  Future<Either<Failure, List<RegistrationEntity>>> call(NoParam param) async {
    return await repository.load();
  }
}
