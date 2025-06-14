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
      body: Container(
        decoration: BoxDecoration(gradient: Config.primaryToSecondaryGradient),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hello Again !!",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Welcome back you've \n been missed !!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                spaceHeight(50),
                Card(
                  elevation: 8,
                  shadowColor: Config.grey2Clr,
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: sW(context) / 1.4,
                    // height: 200,
                    child: Column(
                      spacing: 20,
                      children: [
                        spaceHeight(20),
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
                        spaceHeight(10),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            switch (state) {
                              case Error e:
                                EasyLoading.showError(e.error);
                                break;
                              case LoginSuccess _:
                                EasyLoading.showSuccess("login success !!");
                                navigatorKey.currentState!.pushReplacementNamed(
                                  '/home',
                                );
                              default:
                            }
                          },
                          builder: (context, state) {
                            switch (state) {
                              case Loading _:
                                return CustomBtn().loader(
                                  size: Size(sW(context) / 2, 35),
                                );
                              default:
                                return CustomBtn().normal(
                                  txt: "Login",
                                  onPressed: () {
                                    if (emailCntr.text.isEmpty) {
                                      errorToast(
                                        context,
                                        msg: "please enter email !!",
                                      );
                                    } else if (passwordCntr.text.isEmpty) {
                                      errorToast(
                                        context,
                                        msg: "please enter password !!",
                                      );
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
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              onPressed: () {
                                navigatorKey.currentState!.pushNamed(
                                  "/register",
                                );
                              },
                            ),
                          ],
                        ),

                        spaceHeight(20),
                      ],
                    ),
                  ),
                ),
                spaceHeight(20),
                Text("version - 1.0.0"),
              ],
            ),
          ),
        ),
      ),
    );

    
  }
}
