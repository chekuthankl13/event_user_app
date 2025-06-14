import 'package:event_user/core/config/config.dart';
import 'package:event_user/core/utils/utils.dart';
import 'package:event_user/features/auth/cubit/auth_cubit.dart';
import 'package:event_user/widgets/custom_btn.dart';
import 'package:event_user/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailCntr = TextEditingController();
  TextEditingController passwordCntr = TextEditingController();
  TextEditingController nameCntr = TextEditingController();
  TextEditingController phoneCntr = TextEditingController();

  @override
  void dispose() {
    emailCntr.dispose();
    passwordCntr.dispose();
    nameCntr.dispose();
    phoneCntr.dispose();

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
                  "Please create your account!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                spaceHeight(10),
                Card(
                  elevation: 8,
                  shadowColor: Config.grey2Clr,
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: sW(context) / 1.4,
                    child: Column(
                      spacing: 20,
                      children: [
                        spaceHeight(20),

                        CustomField().simple(
                          cntr: nameCntr,
                          leadingIc: Icons.person,
                          label: "Enter Username",
                          hint: "eg: jhon",
                        ),
                        CustomField().simple(
                          cntr: phoneCntr,
                          isnum: true,
                          leadingIc: Icons.phone,
                          label: "Enter Phone",
                          hint: "eg: 9869689",
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
                              case RegisterSuccess _:
                                EasyLoading.showSuccess(
                                  "registration success !!",
                                );
                                navigatorKey.currentState!.pushReplacementNamed(
                                  '/login',
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
                                  txt: "Register",
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
                                    } else if (nameCntr.text.isEmpty) {
                                      errorToast(
                                        context,
                                        msg: "please enter name !!",
                                      );
                                    } else if (phoneCntr.text.isEmpty) {
                                      errorToast(
                                        context,
                                        msg: "please enter phone !!",
                                      );
                                    } else {
                                      context.read<AuthCubit>().register(
                                        name: nameCntr.text,
                                        phone: phoneCntr.text,
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
