import 'package:event_user/core/db/db_service.dart';
import 'package:event_user/features/auth/di/auth_di.dart';
import 'package:event_user/features/event/di/event_di.dart';
import 'package:event_user/features/home/cubit/nav_cubit.dart';
import 'package:event_user/features/registration/di/reg_di.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

var sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => http.Client());
  sl.registerFactory(() => DbService());
  sl.registerFactory(() => NavCubit());

  await authInit(sl);
  await eventInit(sl);
  await regInit(sl);
}
