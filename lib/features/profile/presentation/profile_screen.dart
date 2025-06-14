import 'package:event_user/core/config/config.dart';
import 'package:event_user/core/db/db_service.dart';
import 'package:event_user/core/utils/utils.dart';
import 'package:event_user/features/home/cubit/nav_cubit.dart';
import 'package:event_user/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> cred = DbService().getCred();
    return Column(
      spacing: 10,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),

          width: sW(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Config.violetClr,
          ),
          child: Row(
            spacing: 20,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Config.violetClr,
                  border: Border.all(color: Config.orangeAccent),
                ),
                alignment: Alignment.center,
                child: Text(
                  cred['name'].toString().split("")[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tile(
                    ic: Icons.person_2_outlined,

                    txt: "username",
                    val: cred['name'].toString(),
                  ),
                  tile(
                    ic: Icons.mail_outline_rounded,

                    txt: "email",
                    val: cred['email'].toString(),
                  ),
                  tile(
                    ic: Icons.call_outlined,

                    txt: "phone",
                    val: cred['phone'].toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(color: Colors.grey.shade200),
        ),
        GestureDetector(
          onTap: () async {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text("Log Out !!"),
                insetPadding: EdgeInsets.all(10),
                backgroundColor: Colors.white,
                titlePadding: EdgeInsets.all(20),
                titleTextStyle: TextStyle(
                  // fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Config.violetClr,
                ),
                contentPadding: EdgeInsets.all(10),
                content: SizedBox(
                  width: sW(context),
                  child: Text(
                    "Are you sure, you want to Logout from the app ?",
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text("cancel"),
                    onPressed: () {
                      navigatorKey.currentState!.pop();
                    },
                  ),

                  CustomBtn().normal(
                    txt: "Log out",
                    color: Config.violetClr,
                    size: Size(80, 30),
                    onPressed: () async {
                      EasyLoading.show();
                      context.read<NavCubit>().update(0);
                      await DbService().clearCred();
                      navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        "/splash",
                        (route) => false,
                      );

                      EasyLoading.dismiss();
                    },
                  ),
                ],
              ),
            );
          },
          child: Container(
            height: 50,
            margin: EdgeInsets.all(10),
            width: sW(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Config.violetClr, blurRadius: .7)],
            ),
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                spaceWidth(5),

                Icon(Icons.exit_to_app, color: Config.greyClr),
                Expanded(
                  child: Text("Logout", style: TextStyle(color: Colors.red)),
                ),
                Icon(Icons.arrow_right_rounded, color: Config.greyClr),
                spaceWidth(5),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget tile({txt, val, ic, isIc = false}) {
  return Row(
    spacing: 2,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      isIc
          ? Icon(ic, color: Colors.white)
          : Text(
              "$txt :",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
      isIc ? spaceWidth(7) : empty(),
      Text(
        val,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
