import 'package:event_user/core/config/config.dart';
import 'package:event_user/core/utils/utils.dart';
import 'package:event_user/features/registration/cubit/reg_cubit.dart';
import 'package:event_user/features/registration/domain/entity/registration_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistartionScreen extends StatefulWidget {
  const RegistartionScreen({super.key});

  @override
  State<RegistartionScreen> createState() => _RegistartionScreenState();
}

class _RegistartionScreenState extends State<RegistartionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegCubit, RegState>(
      builder: (context, state) {
        switch (state) {
          case Loading _:
            return loading();
          case Error e:
            return error(
              e.error,
              onPressed: () => context.read<RegCubit>().load(),
            );
          case Loaded d:
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              color: Config.violetClr,
              backgroundColor: Colors.white,
              onRefresh: () => context.read<RegCubit>().load(),
              child: body(d.reg),
            );
          default:
            return loading();
        }
      },
    );
  }

  body(List<RegistrationEntity> events) {
    return events.isEmpty
        ? itemEmpty(context, "NO REGISTRATION FOUND !!")
        : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
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
                  // await viewDialog(context, data);
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
                    child: Column(
                      spacing: 5,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clr[index],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                data.eventName.split("")[0].toUpperCase(),
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
                                      Icon(
                                        Icons.numbers,
                                        color: Config.grey2Clr,
                                      ),
                                      Text(
                                        data.eventName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  tile(
                                    txt: "Event Location",
                                    val: data.location,
                                  ),
                                  tile(txt: "Event Date", val: data.eventDate),
                                  tile(
                                    txt: "Description",
                                    val: data.description,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        tile(
                          isIc: true,
                          ic: Icons.person_2_outlined,
                          val: data.name,
                        ),
                        tile(
                          isIc: true,
                          ic: Icons.mail_outline,
                          val: data.email,
                        ),

                        tile(
                          isIc: true,
                          ic: Icons.call_outlined,
                          val: data.phone,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  Row tile({txt, val, ic, isIc = false}) {
    return Row(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isIc
            ? Icon(ic, color: Config.greyClr)
            : Text(
                "$txt :",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
        isIc ? spaceWidth(7) : empty(),
        Expanded(
          child: Text(val, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
      ],
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
