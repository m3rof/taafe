import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/modules/login/login_cubit/login_state.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/value_app.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  static bool confirmTest = false;

  void checkValidation(
      {required context,
      required GlobalKey<FormState> key,
      required TextEditingController emailController,
      required TextEditingController passwordController,
      required TextEditingController confirmController,
      required TextEditingController userController}) {
    if (key.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      String confirm = confirmController.text;
      String user = userController.text;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
      emit(CheckValidatorRegisterState());
    }
  }

  void signUp(String email,String password,String role){

  }
}
