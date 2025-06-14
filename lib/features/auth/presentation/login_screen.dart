import 'package:event_user/core/config/config.dart';
import 'package:event_user/core/utils/utils.dart';
import 'package:event_user/features/auth/cubit/auth_cubit.dart';
import 'package:event_user/widgets/custom_btn.dart';
import 'package:event_user/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCntr = TextEditingController();
  TextEditingController passwordCntr = TextEditingController();

  @override
  void dispose() {
    emailCntr.dispose();
    passwordCntr.dispose();
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            SizedBox(
              height: sH(context) / 3,
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hello Again !!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Welcome back you've \n been missed !!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            CustomField().simple(
              cntr: emailCntr,
              leadingIc: Icons.person,
              label: "Enter email",
              hint: "eg: jhon@gmail.com",
            ),
            CustomField().simple(
              cntr: passwordCntr,
              leadingIc: Icons.lock,
              label: "Enter Password",
              hint: "eg: ***",
            ),
            spaceHeight(20),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                switch (state) {
                  case Error e:
                    EasyLoading.showError(e.error);
                    break;
                  case LoginSuccess _:
                    EasyLoading.showSuccess("login success !!");
                    navigatorKey.currentState!.pushReplacementNamed('/home');
                  default:
                }
              },
              builder: (context, state) {
                switch (state) {
                  case Loading _:
                    return CustomBtn().loader(size: Size(sW(context) / 2, 35));
                  default:
                    return CustomBtn().normal(
                      txt: "Login",
                      onPressed: () {
                        if (emailCntr.text.isEmpty) {
                          errorToast(context, msg: "please enter email !!");
                        } else if (passwordCntr.text.isEmpty) {
                          errorToast(context, msg: "please enter password !!");
                        } else {
                          context.read<AuthCubit>().login(
                            password: passwordCntr.text,
                            email: emailCntr.text,
                          );
                        }
                      },
                      size: Size(sW(context) / 2, 35),
                    );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account ?"),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Config.violetClr,
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  onPressed: () {
                    navigatorKey.currentState!.pushNamed("/register");
                  },
                ),
              ],
            ),
            Text("version - 1.0.0"),
          ],
        ),
      ),
    );
  }
}
