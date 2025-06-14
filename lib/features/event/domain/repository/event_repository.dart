import 'package:dartz/dartz.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/features/event/domain/entity/event_entity.dart';


abstract class EventRepository {
  Future<Either<Failure, List<EventEntity>>> load();

  

}
