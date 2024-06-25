import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/register/register_cubit/register_cubit.dart';
import 'package:taafe/modules/register/register_cubit/register_state.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';

import '../resourses/value_app.dart';

class InputField extends StatelessWidget {
  final String? title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? textType;
  final bool isPassword;

  const InputField(
      {this.title,
      required this.hint,
      this.controller,
      this.widget,
      this.textType,
      this.isPassword = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          bool showPwd = cubit.showPwd;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SizeManager.s16,
              vertical: SizeManager.s5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: StylesManager.label,
                  ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    obscureText: isPassword && !showPwd,
                    controller: controller,
                    keyboardType: textType,
                    autofocus: false,
                    style: StylesManager.label,
                    cursorColor: ColorManager.primaryColor,
                    decoration: InputDecoration(
                      suffixIcon: isPassword
                          ? IconButton(
                              onPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              icon: cubit.icon,
                            )
                          : widget,
                      hintText: hint,
                      hintStyle: StylesManager.hint,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 1,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: ColorManager.primaryColor,
                            width: 2,
                          )),
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
