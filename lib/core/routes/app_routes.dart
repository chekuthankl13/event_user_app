import 'package:event_user/core/di/di.dart';
import 'package:event_user/features/auth/cubit/auth_cubit.dart';
import 'package:event_user/features/auth/presentation/login_screen.dart';
import 'package:event_user/features/auth/presentation/register_screen.dart';
import 'package:event_user/features/event/domain/entity/event_entity.dart';
import 'package:event_user/features/home/presentation/home_screen.dart';
import 'package:event_user/features/registration/cubit/reg_cubit.dart';
import 'package:event_user/features/registration/presentation/add_reg_screen.dart';
import 'package:event_user/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class AppRoutes {
  Route? route(RouteSettings setting) {
    switch (setting.name) {
      case "/splash":
        return page(child: const SplashScreen());
      case "/login":
        return page(
          child: BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: LoginScreen(),
          ),
        );
      case "/register":
        return page(
          child: BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: RegisterScreen(),
          ),
        );
      case "/reg":
        var args = setting.arguments as EventEntity;
        return page(
          child: BlocProvider(
            create: (context) => sl<RegCubit>(),
            child: AddRegScreen(arg: args,),
          ),
        );
      case "/home":
        return page(child: const HomeScreen());
      default:
        return null;
    }
  }
}

PageTransition page({required child}) =>
    PageTransition(type: PageTransitionType.fade, child: child);
