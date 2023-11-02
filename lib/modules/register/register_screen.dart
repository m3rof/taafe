import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/register/register_cubit/register_state.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
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
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState>key = GlobalKey();

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
      builder: (context, state) =>
          Scaffold(
            backgroundColor: ColorManager.primaryColor,
            body: Padding(
              padding: const EdgeInsets.all(SizeManager.s35),
              child: SingleChildScrollView(
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: hightMedia(
                            context: context, h: SizeManager.s_03),
                      ),
                      userPhoto(null),
                      SizedBox(
                        height: hightMedia(
                            context: context, h: SizeManager.s_03),
                      ),
                      createAccountText(),
                      const SizedBox(
                        height: SizeManager.s28,
                      ),
                      line(),
                      const SizedBox(
                        height: SizeManager.s30,
                      ),
                      textFieldRegister(
                        textInputType: TextInputType.text,
                        controller: username,
                        hint: StringManager.userRegister,
                        validator: StringManager.userValidatorRegister,
                      ),
                      const SizedBox(
                        height: SizeManager.s20,
                      ),
                      textFieldRegister(
                        textInputType: TextInputType.emailAddress,
                        email: true,
                        controller: email,
                        hint: StringManager.emailRegister,
                        validator: StringManager.emailValidatorRegister,
                      ),
                      const SizedBox(
                        height: SizeManager.s20,
                      ),
                      textFieldRegister(
                        textInputType: TextInputType.visiblePassword,
                        controller: password,
                        hint: StringManager.passwordRegister,
                        validator: StringManager.passwordValidatorRegister,
                      ),
                      const SizedBox(
                        height: SizeManager.s20,
                      ),
                      textFieldRegister(
                        textInputType: TextInputType.visiblePassword,
                        controller: confirmPassword,
                        hint: StringManager.confirmRegister,
                        validator: StringManager.confirmValidatorRegister,
                      ),
                      const SizedBox(
                        height: SizeManager.s28,
                      ),
                      floatingButton(
                          (){
                            cubit.checkValidation(context: context,key: key,
                                emailController: email,
                                passwordController: password,
                                confirmController: confirmPassword,
                                userController: username);
                          },
                          const Image(
                            image: AssetImage(AssetsManager.right),
                            width: SizeManager.s24,
                            height: SizeManager.s24,),
                        width: SizeManager.s50,
                        height: SizeManager.s50
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
