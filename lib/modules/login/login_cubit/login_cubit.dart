import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/modules/login/login_cubit/login_state.dart';
import 'package:taafe/modules/register/register_screen.dart';

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

  void moveRegister(context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen(),));
    emit(NavigationRegisterState());
  }

  void checkValidation(
      {
        required context,
        required GlobalKey<FormState> key,
      required TextEditingController emailController,
      required TextEditingController passwordController}) {
    if (key.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      print(email);
      print(password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
      emit(CheckValidatorLoginState());
    }
  }
}
