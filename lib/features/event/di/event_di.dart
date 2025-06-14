import 'package:event_user/features/event/cubit/event_cubit.dart';
import 'package:event_user/features/event/data/data_source/event_remote_data_source.dart';
import 'package:event_user/features/event/data/repository/event_repository_impl.dart';
import 'package:event_user/features/event/domain/repository/event_repository.dart';
import 'package:event_user/features/event/domain/usecase/load_event_usecase.dart';
import 'package:get_it/get_it.dart';

Future<void> eventInit(GetIt sl) async {
  sl.registerFactory(() => EventCubit(sl()));
  sl.registerLazySingleton(() => LoadEventUsecase(repository: sl()));
 
  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<EventRemoteDataSource>(
    () => EventRemoteDataSourceImpl(client: sl(), dbService: sl()),
  );
}
