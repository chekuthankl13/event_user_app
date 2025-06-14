
import 'package:event_user/core/routes/app_routes.dart';
import 'package:event_user/core/theme/app_theme.dart';
import 'package:event_user/core/utils/utils.dart';
import 'package:event_user/features/home/cubit/nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

import 'core/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => sl<NavCubit>(),
        ),
        
      ],
      child: MaterialApp(
        title: "EVENT User",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        navigatorKey: navigatorKey,
        initialRoute: '/splash',
        onGenerateRoute: AppRoutes().route,
        builder: EasyLoading.init(),
      ),
    );
  }
}
