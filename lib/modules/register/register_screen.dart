import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/modules/register/register_cubit/register_state.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';
import 'package:taafe/shared/resourses/value_app.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import 'register_cubit/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController username;

  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  GlobalKey<FormState> key = GlobalKey();

  @override
  void initState() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: SizeManager.s20),
                  width: double.infinity,
                  height: SizeManager.s170,
                  decoration: const BoxDecoration(
                      color: ColorManager.primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(SizeManager.s40))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createAccountText(),
                      const SizedBox(
                        height: SizeManager.s28,
                      ),
                      line(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SizeManager.s30),
                  child: textFieldRegister(
                    textInputType: TextInputType.text,
                    controller: username,
                    hint: StringManager.userRegister,
                    validator: StringManager.userValidatorRegister,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SizeManager.s30),
                  child: InkWell(
                    onTap: () {
                      cubit.showCalender(context: context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(SizeManager.s16),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(SizeManager.s30),
                          ),
                          border: Border.all(color: ColorManager.primaryColor)),
                      child: Row(
                        children: [
                          Text(
                              DateFormat('MM/dd/yyyy').format(cubit.dateTime),
                              style: StylesManager.headPrimary3.copyWith(
                                  fontSize: SizeManager.s18,
                                  fontWeight: FontWeight.w400)),
                          const Spacer(),
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: ColorManager.primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SizeManager.s30),
                  child: textFieldRegister(
                    textInputType: TextInputType.emailAddress,
                    email: true,
                    controller: email,
                    hint: StringManager.emailRegister,
                    validator: StringManager.emailValidatorRegister,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SizeManager.s30),
                  child: textFieldRegister(
                    obsurce: cubit.visibility1,
                    prefixIcon: IconButton(
                      onPressed: () {
                        cubit.changeVisibility();
                        cubit.changeIconVisibility();
                      },
                      icon: cubit.iconVisibility,
                      color: ColorManager.primaryColor,
                    ),
                    textInputType: TextInputType.visiblePassword,
                    controller: password,
                    hint: StringManager.passwordRegister,
                    validator: StringManager.passwordValidatorRegister,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SizeManager.s30),
                  child: textFieldRegister(
                    suffixIcon:
                        confirmPassword.text.trim() == password.text.trim() &&
                                password.text != '' &&
                                confirmPassword != ''
                            ? const Icon(Icons.done,
                                color: ColorManager.primaryColor,
                                size: SizeManager.s28)
                            : null,
                    textInputType: TextInputType.visiblePassword,
                    controller: confirmPassword,
                    hint: StringManager.confirmRegister,
                    validator: StringManager.confirmValidatorRegister,
                    obsurce: cubit.visibility2,
                    prefixIcon: IconButton(
                      onPressed: () {
                        cubit.changeVisibility2();
                        cubit.changeIconVisibility2();
                      },
                      icon: cubit.iconVisibility2,
                      color: ColorManager.primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SizeManager.s30),
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text(
                            'male',
                            style: StylesManager.or.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          activeColor: ColorManager.primaryColor,
                          value: RegisterCubit.gender[0],
                          groupValue: cubit.currentType,
                          onChanged: (value) => cubit.radioFunction(value),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          activeColor: ColorManager.primaryColor,
                          title: Text(
                            'female',
                            style: StylesManager.or.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          value: RegisterCubit.gender[1],
                          groupValue: cubit.currentType,
                          onChanged: (value) => cubit.radioFunction(value),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: SizeManager.s28,
                ),
                ElevatedButton(
                    onPressed: () {
                      cubit.checkValidation(
                          context: context,
                          key: key,
                          emailController: email,
                          passwordController: password,
                          confirmController: confirmPassword,
                          userController: username);
                    },
                    child: const Text('Register',style: TextStyle(color: ColorManager.textWhite))),
                const SizedBox(
                  height: SizeManager.s28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
