
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/user_model/user_model.dart';
import '../../../shared/components/components.dart';

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
  }) async {
    emit(AppRegisterLoadingState());

    try {
      var value = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(value.user!.email);
      print(value.user!.uid);
      emit(AppCreateUserSuccessState());

      userCreate(
        email: email,
        name: name,
        date: date,
        uId: value.user!.uid,
        gender: gender,
        specialty: specialty,
      );
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
  }) async {
    userData = UserData(
      email: email,
      name: name,
      date: date,
      uId: uId,
      gender: gender,
      specialty: specialty,
    );
    emit(AppCreateUserLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
          .set(userData.toMap());

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

  static final List<String> gender = ['male ', 'female'];
  String currentType = gender[0];

  void radioFunction(value) {
    currentType = value;
    emit(RegistergenderState());
  }
}
