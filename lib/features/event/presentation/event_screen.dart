import 'package:event_user/core/config/config.dart';
import 'package:event_user/core/utils/utils.dart';
import 'package:event_user/features/event/cubit/event_cubit.dart';
import 'package:event_user/features/event/domain/entity/event_entity.dart';
import 'package:event_user/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        switch (state) {
          case Loading _:
            return loading();
          case Error e:
            return error(
              e.error,
              onPressed: () => context.read<EventCubit>().load(),
            );
          case Loaded d:
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              color: Config.violetClr,
              backgroundColor: Colors.white,
              onRefresh: () => context.read<EventCubit>().load(),
              child: body(d.events),
            );
          default:
            return loading();
        }
      },
    );
  }

  body(List<EventEntity> events) {
    return events.isEmpty
        ? itemEmpty(context, "NO EVENTS FOUND !!")
        : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: events.length,
            itemBuilder: (context, index) {
              var data = events[index];
              final List<Color> clr = List.generate(
                events.length,
                (i) => _getColorFromBase(i, events.length),
              );
              return InkWell(
                splashColor: Config.whiteClr,
                onTap: () async {
                  await viewDialog(context, data);
                },
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  color: Color.fromARGB(255, 254, 254, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                  margin: EdgeInsets.all(5),
                  
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      spacing: 10,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: clr[index],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            data.title.split("")[0].toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Row(
                                spacing: 2,
                                children: [
                                  Icon(Icons.numbers, color: Config.greyClr),
                                  Text(
                                    data.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 2,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Config.greyClr,
                                  ),
                                  Expanded(
                                    child: Text(
                                      data.location,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 2,
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: Config.greyClr,
                                  ),
                                  Text(
                                    data.date,
                                    style: TextStyle(
                                      color: Config.redAccentLigthClr,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  Future<void> viewDialog(BuildContext context, EventEntity data) async {
    showDialog(
      context: context,
      builder: (BuildContext contexts) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(Icons.numbers, color: Config.violetClr),
              Text(data.title),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      'Description:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(data.description),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Location:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    spaceWidth(4),
                    Expanded(child: Text(data.location)),
                  ],
                ),
                Row(
                  spacing: 2,
                  children: [
                    Text(
                      'Date:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    spaceWidth(2),
                    Text(data.date),
                  ],
                ),
                // Add more fields as needed
              ],
            ),
          ),
          actions: [
            CustomBtn().normal(
              size: Size(100, 40),
              txt: "Register",
              onPressed: () {
                //  navigatorKey.currentState!.pop();
                navigatorKey.currentState!.pushReplacementNamed(
                  "/reg",
                  arguments: data,
                );
              },
            ),
            TextButton(
              onPressed: () => navigatorKey.currentState!.pop(),
              child: Text('Close', style: TextStyle(color: Config.violetClr)),
            ),
          ],
        );
      },
    );
  }
}

Color _getColorFromBase(int index, int totalItems) {
  // Convert violetClr to HSL for easier hue manipulation
  HSLColor hslColor = HSLColor.fromColor(
    const Color.fromARGB(255, 206, 223, 255),
  );
  // Calculate hue shift to evenly distribute colors
  double hueShift = (360.0 / totalItems) * index;
  // Apply hue shift, keeping saturation and lightness constant
  HSLColor shiftedColor = hslColor.withHue((hslColor.hue + hueShift) % 350);
  return shiftedColor.toColor();
}
