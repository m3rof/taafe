import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/shared/network/remote/end_points.dart';
import 'package:taafe/shared/resourses/color_manager.dart';

import '../../../shared/components/components.dart';
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
      signUp(context, userController.text,emailController.text, passwordController.text,dateTime,currentType);
      emit(CheckValidatorRegisterState());
    }
  }

  void signUp(context,String name,String email, String password,DateTime birthDate,String gender) async{
    emit(RegisterLoadingState());
    try{
    Response response=await DioHelper.postData(
            url: signupPatient,
            data: {'email': email,'password':password, 'name': name, 'birthDate': '$birthDate','gender': gender,});
           Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
           print(response.data);
      emit(RegisterSuccessState());
    } on DioException catch (e) {
        // The server responded with an error status code (4xx or 5xx)
        if (e.response!.statusCode == 406 || e.response!.statusCode == 404) {
          print(e.response!.data);
          // Handle the 406 error here
        } else {
          print('Error: ${e.response!.statusCode} - ${e.response!.statusMessage}');
          // Handle other HTTP errors if needed
        }
      }
      emit(RegisterErrorState());

  }

  bool visibility1 = true;
  Widget iconVisibility = const Icon(Icons.visibility_off_outlined);

  void changeVisibility() {
    visibility1 = !visibility1;
    emit(RegisterChangeVisibilityState());
  }

  void changeIconVisibility() {
    visibility1
        ? iconVisibility = const Icon(
            Icons.visibility_off_outlined,
            color: ColorManager.primaryColor,
          )
        : iconVisibility =
            const Icon(Icons.visibility_outlined, color: ColorManager.primaryColor);
    emit(RegisterChangeIconVisibilityState());
  }

  bool visibility2 = true;
  Widget iconVisibility2 = const Icon(Icons.visibility_off_outlined);

  void changeVisibility2() {
    visibility2 = !visibility2;
    emit(RegisterChangeVisibility2State());
  }

  void changeIconVisibility2() {
    visibility2
        ? iconVisibility2 = const Icon(
            Icons.visibility_off_outlined,
            color: ColorManager.primaryColor,
          )
        : iconVisibility2 =
            const Icon(Icons.visibility_outlined, color: ColorManager.primaryColor);
    emit(RegisterChangeIconVisibility2State());
  }

    DateTime dateTime=DateTime.now();
    bool selected=false;

  Widget buildDatePicker() => SizedBox(
    height: 180,
    child: CupertinoDatePicker(
      initialDateTime: dateTime,
      maximumYear: DateTime.now().year,
      onDateTimeChanged: (value) => resultDateTime(value: value),
      mode: CupertinoDatePickerMode.date,
    ),
  );

  void resultDateTime({required value}) {
    dateTime = value;
    emit(RegisterDateTimeState());
  }

  void showCalender({required context}) {
     showSheet(context, buildDatePicker(), () {
       selected=true;
       print(DateFormat('MM/dd/yyyy').format(dateTime));
       Navigator.pop(context);
     });
  }

  static final List<String> gender = ['male ', 'female'];
  String currentType=gender[0];

  void radioFunction(value){
    currentType=value;
    emit(RegistergenderState());
  }


}
