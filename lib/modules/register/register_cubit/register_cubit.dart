import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/modules/login/login_cubit/login_state.dart';
import 'package:taafe/shared/network/remote/end_points.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/value_app.dart';

import '../../../shared/network/remote/dio_helper.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void checkValidation(
      {required context,
      required GlobalKey<FormState> key,
      required TextEditingController emailController,
      required TextEditingController passwordController,
      required TextEditingController confirmController,
      required TextEditingController userController}) {
    if (key.currentState!.validate()) {
      signUp(context,emailController.text,passwordController.text,'patient');
      emit(CheckValidatorRegisterState());
    }
  }

  void signUp(context, String email, String password,String role) {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: signup,
        data: {'email': email, 'password': password,'role':role}
    ).then((value) {
      print(value.data);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
      emit(RegisterSuccessState());
    }).catchError((error) {
      print('catch error: $error');
      emit(RegisterErrorState());
    });
  }
  bool visibility = true;
  Widget iconVisibility = const Icon(Icons.visibility_off_outlined);

  void changeVisibility() {
    visibility = !visibility;
    emit(RegisterChangeVisibilityState());
  }

  void changeIconVisibility() {
    visibility
        ? iconVisibility = const Icon(Icons.visibility_off_outlined,color: Colors.white,)
        : iconVisibility = const Icon(Icons.visibility_outlined,color: Colors.white);
    emit(RegisterChangeIconVisibilityState());
  }
}
