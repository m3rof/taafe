import 'dart:ffi';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/modules/login/login_cubit/login_state.dart';
import 'package:taafe/modules/register/register_screen.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/network/remote/dio_helper.dart';
import 'package:taafe/shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool visibility = true;
  Widget iconVisibility = const Icon(Icons.visibility_off_outlined);

  void changeVisibility() {
    visibility = !visibility;
    emit(ChangeVisibilityState());
  }

  void changeIconVisibility() {
    visibility
        ? iconVisibility = const Icon(Icons.visibility_off_outlined)
        : iconVisibility = const Icon(Icons.visibility_outlined);
    emit(ChangeIconVisibilityState());
  }

  void moveRegister(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        ));
    emit(NavigationRegisterState());
  }

  void checkValidation(
      {required context,
      required GlobalKey<FormState> key,
      required TextEditingController emailController,
      required TextEditingController passwordController}) {
    if (key.currentState!.validate()) {
      loginUser(context, emailController.text, passwordController.text);
      emit(CheckValidatorLoginState());
    }
  }

  void loginUser(context, String email, String password)async {
    emit(LoadingLoginState());
    try {
      Response response = await DioHelper.postData(
          url: login,
          data: {'email': email, 'password': password}
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
      emit(SuccessLoginState());
    }on DioException catch (e) {
      if (e.response!.statusCode == 406 || e.response!.statusCode == 404) {
        print(e.response!.data);
        showDialogAwsome(context,'${e.response!.data}',DialogType.error,(){});
      } else {
        print('Error: ${e.response!.statusCode} - ${e.response!.statusMessage}');
        // Handle other HTTP errors if needed
      }
    }
    emit(ErrorLoginState());

  }

}
