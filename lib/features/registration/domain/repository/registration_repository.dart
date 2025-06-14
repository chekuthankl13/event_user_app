import 'package:dartz/dartz.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/features/registration/domain/entity/registration_entity.dart';
import 'package:event_user/features/registration/domain/entity/registration_param.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, List<RegistrationEntity>>> load();

  Future<Either<Failure, String>> add({required RegistrationParam param});
}
