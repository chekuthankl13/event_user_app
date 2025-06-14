import 'package:event_user/core/db/db_service.dart';
import 'package:event_user/core/utils/utils.dart';
import 'package:event_user/features/event/domain/entity/event_entity.dart';
import 'package:event_user/features/registration/cubit/reg_cubit.dart';
import 'package:event_user/widgets/custom_btn.dart';
import 'package:event_user/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddRegScreen extends StatefulWidget {
  final EventEntity arg;
  const AddRegScreen({super.key, required this.arg});

  @override
  State<AddRegScreen> createState() => _AddRegScreenState();
}

class _AddRegScreenState extends State<AddRegScreen> {
  TextEditingController titleCntr = TextEditingController();
  TextEditingController nameCntr = TextEditingController();
  TextEditingController emailCntr = TextEditingController();
  TextEditingController phoneCntr = TextEditingController();
  GlobalKey<FormState> fkey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleCntr.dispose();
    nameCntr.dispose();
    emailCntr.dispose();
    phoneCntr.dispose();
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  void initState() {
    titleCntr.text = widget.arg.title;
    nameCntr.text = DbService().getName();
    emailCntr.text = DbService().getEamil();
    phoneCntr.text = DbService().getPhone();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Event Registration")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          padding: EdgeInsets.all(10),
          child: Form(
            key: fkey,
            child: Column(
              spacing: 20,
              children: [
                CustomField().simple(
                  hint: "eg: sample ",
                  cntr: titleCntr,
                  leadingIc: Icons.numbers,
                  label: "Event Name",
                  isReq: true,
                  isRead: true,
                  isfilter: true,
                ),
                CustomField().simple(
                  hint: "eg: jhon ",
                  cntr: nameCntr,
                  leadingIc: Icons.person,
                  label: "User Name",
                  isReq: true,
                  isfilter: true,
                ),
                CustomField().simple(
                  hint: "eg: 908776097 ",
                  cntr: phoneCntr,
                  leadingIc: Icons.phone,
                  label: "Phone",
                  isReq: true,
                  isnum: true,
                  isfilter: true,
                ),
                CustomField().simple(
                  hint: "eg: test@gmail.com ",
                  cntr: emailCntr,
                  leadingIc: Icons.mail,
                  label: "Email",
                  isReq: true,
                  isnum: true,
                  isfilter: true,
                ),
                BlocConsumer<RegCubit, RegState>(
                  listener: (context, state) {
                    if (state is Error) {
                      EasyLoading.showError(state.error);
                    }

                    if (state is Added) {
                      EasyLoading.showSuccess("successfully registered !!");
                      navigatorKey.currentState!.pop();
                    }
                  },
                  builder: (context, state) {
                    switch (state) {
                      case Loading _:
                        return CustomBtn().loader(
                          size: Size(sW(context) / 2, 40),
                        );

                      default:
                        return CustomBtn().normal(
                          size: Size(sW(context) / 2, 40),
                          txt: "Register",
                          onPressed: () async {
                            if (fkey.currentState!.validate()) {
                              await context.read<RegCubit>().add(
                                email: emailCntr.text,
                                eventId: widget.arg.id,
                                name: nameCntr.text,
                                phone: phoneCntr.text,
                              );
                            }
                          },
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
