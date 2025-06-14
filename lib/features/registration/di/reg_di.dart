import 'package:event_user/features/registration/cubit/reg_cubit.dart';
import 'package:event_user/features/registration/data/data_source/registration_remote_data_source.dart';
import 'package:event_user/features/registration/data/repository/registration_repository_impl.dart';
import 'package:event_user/features/registration/domain/repository/registration_repository.dart';
import 'package:event_user/features/registration/domain/usecase/load_registration_usecase.dart';
import 'package:event_user/features/registration/domain/usecase/register_usecase.dart';
import 'package:get_it/get_it.dart';

Future<void> regInit(GetIt sl) async {
  sl.registerFactory(() => RegCubit(sl(), sl()));
  sl.registerLazySingleton(() => LoadRegistrationUsecase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUsecase(repository: sl()));

  sl.registerLazySingleton<RegistrationRepository>(
    () => RegistrationRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<RegistrationRemoteDataSource>(
    () => RegistrationRemoteDataSourceImpl(client: sl(), dbService: sl()),
  );
}
