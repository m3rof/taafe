import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/login/login_cubit/login_cubit.dart';
import 'package:taafe/modules/login/login_cubit/login_state.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';
import 'package:taafe/shared/resourses/value_app.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> key = GlobalKey();

  @override
  void initState() {
    emailController=TextEditingController();
    passwordController=TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeManager.s35),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  logoLogin(context),
                  welcome(),
                  const SizedBox(
                    height: SizeManager.s24,
                  ),
                  textFieldPrefix(
                      controller: emailController,
                      validator:  StringManager.emailValidatorLogin,
                      icons: const Icon((Icons.account_circle)),
                      textInputType: TextInputType.emailAddress,
                      label: StringManager.email),
                  const SizedBox(
                    height: SizeManager.s20,
                  ),
                  textFieldPrefix(
                      controller: passwordController,
                      validator: StringManager.passwordValidatorLogin,
                      icons: IconButton(
                          onPressed: () {
                            cubit.changeVisibility();
                            cubit.changeIconVisibility();
                          },
                          icon: cubit.iconVisibility),
                      obsurce: cubit.visibility,
                      textInputType: TextInputType.visiblePassword,
                      label: StringManager.password),
                  const SizedBox(
                    height: SizeManager.s24,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        cubit.checkValidation(
                          context: context,
                            key: key,
                            emailController: emailController,
                            passwordController: passwordController);
                      },
                      child: const Text(StringManager.signin)),
                  const SizedBox(
                    height: SizeManager.s24,
                  ),
                  textButton(
                      textStyle: StylesManager.or,
                      function: null,
                      text: StringManager.or),
                  const SizedBox(
                    height: SizeManager.s14,
                  ),
                  textButton(
                      textStyle: StylesManager.or,
                      function: null,
                      text: StringManager.loginWith),
                  const SizedBox(
                    height: SizeManager.s24,
                  ),
                  loginIcon(),
                  const SizedBox(
                    height: SizeManager.s18,
                  ),
                  textButton(
                      textStyle: StylesManager.loginCreate,
                      function: () {
                        cubit.moveRegister(context);
                      },
                      text: StringManager.newAccount)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
