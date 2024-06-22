import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

import '../../shared/components/constants.dart';
import '../../shared/resourses/color_manager.dart';
import '../login/login_screen.dart';
import 'register_cubit/register_cubit.dart';
import 'register_cubit/register_state.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is VerifyEmailErrorState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: ColorManager.erroeColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is VerifyEmailSuccessState) {
          Fluttertoast.showToast(
              msg: "Please Check Your Email",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: ColorManager.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
          animatedNavigateAndDelete(
            context: context,
            widget: const LoginScreen(),
            direction: PageTransitionType.fade,
            curve: Curves.bounceIn,
          );
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 320,
                  width: 320,
                ),
                Text(
                  "Please Verify Your Email",
                  style: TextStyle(color: ColorManager.primaryColor),
                ),
                state is VerifyEmailLoadingState
                    ? loadingProgress()
                    : ElevatedButton(
                        onPressed: () {
                          cubit.verifyEmail(context);
                        },
                        child: const Text('Verify Your Email',
                            style: TextStyle(color: ColorManager.textWhite))),
              ],
            ),
          ),
        );
      },
    );
  }
}
