import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:taafe/modules/register/register_cubit/register_state.dart';

import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/family_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';
import 'package:taafe/shared/resourses/value_app.dart';
import 'package:taafe/shared/widgets/app_btn.dart';
import 'package:taafe/shared/widgets/input_Field.dart';

import '../../shared/components/constants.dart';
import 'email_verification_screen.dart';
import 'register_cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();

    TextEditingController email = TextEditingController();

    TextEditingController password = TextEditingController();

    TextEditingController confirmPassword = TextEditingController();
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    var cubit = RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is AppRegisterErrorState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: ColorManager.erroeColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is AppCreateUserErrorState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: ColorManager.erroeColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is AppCreateUserAPISuccessState) {
          Fluttertoast.showToast(
              msg: "Your Register Done Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: ColorManager.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
          animatedNavigateTo(
            context: context,
            widget: const EmailVerificationScreen(),
            direction: PageTransitionType.bottomToTop,
            curve: Curves.bounceIn,
          );
        }
      },
      builder: (context, state) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: SizeManager.s20),
                width: double.infinity,
                height: SizeManager.s170,
                decoration: const BoxDecoration(
                  color: ColorManager.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(SizeManager.s50),
                    bottomLeft: Radius.circular(SizeManager.s50),
                  ),
                ),
                child: Center(
                  child: Text(
                    StringManager.registerCreate,
                    style: StylesManager.registerCreate,
                  ),
                ),
              ),
              InputField(
                hint: "Enter Your Name",
                title: "Username",
                controller: username,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.s20,
                ),
                child: InkWell(
                  onTap: () {
                    cubit.showCalender(context: context);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BirthDay",
                        style: StylesManager.label,
                      ),
                      Container(
                        padding: const EdgeInsets.all(SizeManager.s12),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            border: Border.all(
                              color: ColorManager.primaryColor,
                              width: 2,
                            )),
                        child: Row(
                          children: [
                            Text(
                                DateFormat('MM/dd/yyyy').format(cubit.dateTime),
                                style: StylesManager.headPrimary3.copyWith(
                                  fontSize: SizeManager.s18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FamilyManager.myriad,
                                )),
                            const Spacer(),
                            const Icon(
                              Icons.calendar_month,
                              color: ColorManager.primaryColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InputField(
                hint: "Enter Your Email",
                title: "Email",
                controller: email,
                textType: TextInputType.emailAddress,
              ),
              InputField(
                hint: "Enter Your Password",
                title: "Password",
                controller: password,
                isPassword: true,
              ),
              InputField(
                hint: "Confirm Your Password",
                title: "Confirm Password",
                controller: confirmPassword,
                isPassword: true,
              ),
              InputField(
                title: "Specialty",
                hint: cubit.selectedValue,
                widget: DropdownButton(
                  dropdownColor: ColorManager.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  items: RegisterCubit.specialties
                      .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: FamilyManager.myriad,
                            ),
                          )))
                      .toList(),
                  style: StylesManager.hint,
                  onChanged: (newValue) {
                    cubit.changeSpaciality(newValue);
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: ColorManager.primaryColor,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                ),
              ),
              if (cubit.selectedValue == "Doctor")
                InputField(
                  hint: "What is your role?",
                  title: "Title",
                  controller: title,
                ),
              if (cubit.selectedValue == "Doctor")
                InputField(
                  hint: "Write Something that descripes you",
                  title: "description",
                  controller: description,
                ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        'male',
                        style: StylesManager.label,
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
                        style: StylesManager.label,
                      ),
                      value: RegisterCubit.gender[1],
                      groupValue: cubit.currentType,
                      onChanged: (value) => cubit.radioFunction(value),
                    ),
                  ),
                ],
              ),
              ConditionalBuilder(
                condition: state is! AppRegisterLoadingState,
                builder: (context) {
                  return AppBtn(
                      label: "Register",
                      onPressed: () {
                        if (email.text.isEmpty ||
                            username.text.isEmpty ||
                            password.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please Fill All Fields!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: ColorManager.erroeColor,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else if (password.text != confirmPassword.text) {
                          Fluttertoast.showToast(
                              msg: "Password Dosen't Match!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: ColorManager.erroeColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (cubit.selectedValue == "Doctor" &&
                            (title.text.isEmpty || description.text.isEmpty)) {
                          Fluttertoast.showToast(
                              msg: "Please Tell Us More About You",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: ColorManager.erroeColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          print(cubit.dateTime.toString());
                          cubit.userRegister(
                            email: email.text,
                            password: password.text,
                            name: username.text,
                            date: cubit.dateTime.toString(),
                            gender: cubit.currentType,
                            specialty: cubit.selectedValue,
                            title: title.text,
                            description: description.text,
                          );
                        }
                      });
                },
                fallback: (context) => loadingProgress(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
