import 'package:dartz/dartz.dart';
import 'package:event_user/core/error/exception.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/features/registration/data/data_source/registration_remote_data_source.dart';
import 'package:event_user/features/registration/data/model/registration_param_model.dart';
import 'package:event_user/features/registration/domain/entity/registration_entity.dart';
import 'package:event_user/features/registration/domain/entity/registration_param.dart';
import 'package:event_user/features/registration/domain/repository/registration_repository.dart';

class RegistrationRepositoryImpl extends RegistrationRepository {
  final RegistrationRemoteDataSource remoteDataSource;

  RegistrationRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, String>> add({
    required RegistrationParam param,
  }) async {
    try {
      var res = await remoteDataSource.add(
        param: RegistrationParamModel.fromEntity(param),
      );
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExpectionFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, List<RegistrationEntity>>> load() async {
    try {
      var res = await remoteDataSource.load();
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExpectionFailure(error: e.error));
    }
  }
}
