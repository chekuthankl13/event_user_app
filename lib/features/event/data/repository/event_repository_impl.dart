import 'package:dartz/dartz.dart';
import 'package:event_user/core/error/exception.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/features/event/data/data_source/event_remote_data_source.dart';
import 'package:event_user/features/event/domain/entity/event_entity.dart';
import 'package:event_user/features/event/domain/repository/event_repository.dart';


class EventRepositoryImpl extends EventRepository {
  final EventRemoteDataSource remoteDataSource;

  EventRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<EventEntity>>> load() async {
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
