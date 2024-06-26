import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/modules/login/login_cubit/login_cubit.dart';
import 'package:taafe/modules/login/login_cubit/login_state.dart';
import 'package:taafe/modules/register/register_screen.dart';
import 'package:taafe/shared/components/constants.dart';

import 'package:taafe/shared/resourses/strings_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';
import 'package:taafe/shared/resourses/value_app.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache/cache_helper.dart';
import '../../shared/resourses/color_manager.dart';
import '../../shared/widgets/app_btn.dart';
import '../../shared/widgets/input_Field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is ErrorLoginState) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: ColorManager.erroeColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
        if (state is SuccessLoginState) {
          if (state.user.emailVerified) {
            Fluttertoast.showToast(
              msg: "Welcome!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: ColorManager.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            CacheHelper.saveData(key: "token", value: state.token)
                .then((value) {
              uId = CacheHelper.getData(key: "uId");
              token = CacheHelper.getData(key: "token");
              animatedNavigateAndDelete(
                  context: context,
                  widget: const HomeScreen(),
                  direction: PageTransitionType.fade,
                  curve: Curves.easeInOutBack);
            });
            CacheHelper.saveData(key: "uId", value: state.user.uid);
          } else {
            Fluttertoast.showToast(
              msg: "Please Verifiey Your Email First!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: ColorManager.erroeColor,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logoLogin(context),
              welcome(),
              const SizedBox(
                height: SizeManager.s24,
              ),
              InputField(
                hint: "Enter Your Email",
                title: "Email",
                controller: emailController,
              ),
              InputField(
                hint: "Enter Your Password",
                title: "Password",
                controller: passwordController,
                isPassword: true,
              ),
              const SizedBox(
                height: SizeManager.s24,
              ),
              ConditionalBuilder(
                condition: state is! LoadingLoginState,
                builder: (context) => AppBtn(
                  label: 'Sign In',
                  onPressed: () {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please Fill All Fields!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: ColorManager.erroeColor,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      cubit.loginUser(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context);
                    }
                  },
                ),
                fallback: (context) => loadingProgress(),
              ),
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
              loginIcon(cubit, context),
              const SizedBox(
                height: SizeManager.s18,
              ),
              textButton(
                  textStyle: StylesManager.loginCreate,
                  function: () {
                    moveScreen(context: context, screen: RegisterScreen());
                  },
                  text: StringManager.newAccount),
            ],
          ),
        ),
      ),
    );
  }
}
