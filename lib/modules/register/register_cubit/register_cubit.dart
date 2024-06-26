import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/shared/network/remote/dio_helper.dart';

import '../../../models/user_model/user_model.dart';
import '../../../shared/components/components.dart';

import '../../../shared/network/remote/end_points.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String date,
    required String gender,
    required String specialty,
     String? title,
     String? description,
  }) async {
    emit(AppRegisterLoadingState());

    try {
      var value = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(value.user!.email);
      print(await value.user!.getIdToken());
      

      userCreate(
          email: email,
          name: name,
          date: date,
          uId: value.user!.uid,
          gender: gender,
          specialty: specialty,
          token: await value.user!.getIdToken(),
          title: title,
          description: description,
          );

          emit(AppCreateUserSuccessState());
    } on FirebaseAuthException catch (error) {
      print(error);
      emit(AppRegisterErrorState(error.message ?? "Authintication Failed!"));
    }
  }

  late UserData userData;
  void userCreate({
    required String email,
    required String name,
    required String date,
    required String uId,
    required String gender,
    required String specialty,
    required String? token,
    String? title,
     String? description,
  }) async {
    userData = UserData(
      email: email,
      name: name,
      date: date,
      uId: uId,
      gender: gender,
      specialty: specialty,
      title: title,
      description: description,
    );
    emit(AppCreateUserLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
          .set(userData.toMap());

      if (specialty == "Patient") {
        try {
          emit(AppCreateUserAPILoadingState());
          var value = await DioHelper.postData(url: signupPatient, data: {
            "token": token,
            "birthDate": date,
            "gender": gender,
            "name":name,
          },
          query: {
            "token": token,
            "birthDate": date,
            "gender": gender,
            "name":name,
          },
          );
          emit(AppCreateUserAPISuccessState());
          print("Data: ${value.data}");
        } on DioException catch (error) {
          print("error API:${error.message}");
          print("error API:${error.response}");
          emit(AppCreateUserAPIErrorState());
        }
      }else{
        try {
          emit(AppCreateUserAPILoadingState());
          var value = await DioHelper.postData(url: signupDoctor, data: {
            "token": token,
            "birthDate": date,
            "gender": gender,
            "name":name,
            "title": title,
      "description": description,
          },
          query: {
            "token": token,
            "birthDate": date,
            "gender": gender,
            "name":name,
            "title": title,
      "description": description,
          },
          );
          emit(AppCreateUserAPISuccessState());
          print("Data: ${value.data}");
        } on DioException catch (error) {
          print("error API:${error.message}");
          print("error API:${error.response}");
          emit(AppCreateUserAPIErrorState());
        }
      }

      emit(AppCreateUserSuccessState());
    } on FirebaseException catch (error) {
      print(error.toString());
      emit(AppCreateUserErrorState(error.message ?? "Authintication Failed!"));
    }
  }

  void verifyEmail(context) async {
    emit(VerifyEmailLoadingState());
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      emit(VerifyEmailSuccessState());
    } on FirebaseException catch (error) {
      print(error.toString());
      emit(VerifyEmailErrorState(error.message ?? "Authintication Failed!"));
    }
  }

  Widget icon = const Icon(Icons.remove_red_eye_outlined);
  bool showPwd = false;

  void changePasswordVisibility() {
    showPwd = !showPwd;
    icon = showPwd
        ? const Icon(Icons.visibility_off_outlined)
        : const Icon(Icons.visibility_outlined);
    emit(AppChangePasswordVisibility());
  }

  DateTime dateTime = DateTime.now();
  bool selected = false;

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
      selected = true;
      print(DateFormat('MM/dd/yyyy').format(dateTime));
      Navigator.pop(context);
    });
  }

  static final List<String> gender = ['Male', 'Female'];
  String currentType = gender[0];

  void radioFunction(value) {
    currentType = value;
    emit(RegistergenderState());
  }

  static List<String> specialties = ["Doctor", "Patient"];
  String selectedValue = specialties[1];
  void changeSpaciality(value) {
    selectedValue = value;
    emit(ChangeSpacialityState());
  }
}
