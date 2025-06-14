import 'package:dartz/dartz.dart';
import 'package:event_user/core/error/failure.dart';


abstract class Usecase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}

class NoParam {
  
}