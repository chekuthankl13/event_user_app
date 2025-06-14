import 'package:event_user/core/config/config.dart';
import 'package:event_user/core/di/di.dart';
import 'package:event_user/core/utils/utils.dart';
import 'package:event_user/features/event/cubit/event_cubit.dart';
import 'package:event_user/features/event/presentation/event_screen.dart';
import 'package:event_user/features/home/cubit/nav_cubit.dart';
import 'package:event_user/features/profile/presentation/profile_screen.dart';
import 'package:event_user/features/registration/cubit/reg_cubit.dart';
import 'package:event_user/features/registration/presentation/registartion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EVENT APP")),
      bottomNavigationBar: btmNav(),
      body: BlocBuilder<NavCubit, int>(
        builder: (context, state) {
          switch (state) {
            case 0:
              return BlocProvider(
                create: (context) => sl<EventCubit>()..load(),
                child: EventScreen(),
              );
            case 1:
              return BlocProvider(
                create: (context) => sl<RegCubit>()..load(),
                child: RegistartionScreen(),
              );
            default:
              return ProfileScreen();
          }
        },
      ),
    );
  }

  btmNav() {
    return BottomAppBar(
      height: kToolbarHeight + 10,
      notchMargin: 0,
      padding: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent, // Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent, // Config.baseClr,
      color: Colors.transparent,
      child: BlocBuilder<NavCubit, int>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: Config.violetClr, // Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: .8),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.black12.withAlpha(5),
                    onTap: () {
                      context.read<NavCubit>().update(0);
                    },
                    child: state == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.white, // Config.baseClr,
                                size: 20,
                              ),
                              spaceWidth(2),
                              const Text(
                                'Events',
                                style: TextStyle(
                                  color: Colors.white, // Config.baseClr,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        // )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_border,
                                color: Config.greyClr, //.shade700
                                size: 20,
                              ),
                              spaceWidth(2),
                              Text(
                                'Events',
                                style: TextStyle(
                                  color: Config.greyClr,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VerticalDivider(color: Colors.white12),
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      context.read<NavCubit>().update(1);
                    },
                    child: state == 1
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.sticky_note_2,
                                color: Colors.white, // Config.baseClr,
                                size: 20,
                              ),
                              spaceWidth(2),
                              const Text(
                                'Registrations',
                                style: TextStyle(
                                  color: Colors.white, // Config.baseClr,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        // )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.sticky_note_2_outlined,
                                color: Config.greyClr,
                                size: 20,
                              ),
                              spaceWidth(2),
                              Text(
                                'Registrations',
                                style: TextStyle(
                                  color: Config.greyClr,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VerticalDivider(color: Colors.white12),
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      context.read<NavCubit>().update(2);
                    },
                    child: state == 2
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.person_3,
                                color: Colors.white, // Config.baseClr,
                                size: 20,
                              ),
                              spaceWidth(2),
                              const Text(
                                'Profile',
                                style: TextStyle(
                                  color: Colors.white, // Config.baseClr,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        // )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_3_outlined,
                                color: Config.greyClr,
                                size: 20,
                              ),
                              spaceWidth(2),
                              Text(
                                'Profile',
                                style: TextStyle(
                                  color: Config.greyClr,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
