import 'package:dartz/dartz.dart';
import 'package:event_user/core/db/db_service.dart';
import 'package:event_user/core/error/exception.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:event_user/features/auth/data/model/user_param_model.dart';
import 'package:event_user/features/auth/domain/entity/user_entity.dart';
import 'package:event_user/features/auth/domain/entity/user_param.dart';
import 'package:event_user/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final DbService dbService;

  AuthRepositoryImpl( {required this.remoteDataSource,required this.dbService});
  @override
  Future<Either<Failure, UserEntity>> login({required UserParam param}) async {
    try {
      var res = await remoteDataSource.login(
        param: UserParamModel.fromEntity(param),
      );
      await dbService.saveCred(res);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExpectionFailure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> register({required UserParam2 param}) async {
    try {
      var res = await remoteDataSource.register(
        param: UserParamModel2.fromEntity(param),
      );

      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExpectionFailure(error: e.toString()));
    }
  }
}
