import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/shared/network/remote/end_points.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import '../../../models/user_model/user_model.dart';
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
      userRegister(
          email: emailController.text,
          password: passwordController.text,
          name: userController.text,
          date: dateTime.toString(),
          gender: currentType);
      emit(CheckValidatorRegisterState());
    }
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String date,
    required String gender,
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
  }) async {
    userData = UserData(
      email: email,
      name: name,
      date: date,
      uId: uId,
      gender: gender,
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

  void signUp(
    context,
    String name,
    String email,
    String password,
    DateTime birthDate,
    String gender,
  ) async {
    emit(RegisterLoadingState());
    try {
      Response response = await DioHelper.postData(url: signupPatient, data: {
        'email': email,
        'password': password,
        'name': name,
        'birthDate': '$birthDate',
        'gender': gender,
      });
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
        showDialogAwsome(context, '${e.response!.data}', DialogType.info, () {
          Navigator.pop(context);
        });
      } else {
        print(
            'Error: ${e.response!.statusCode} - ${e.response!.statusMessage}');
        // Handle other HTTP errors if needed
      }
      emit(RegisterErrorState());
    }
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
        : iconVisibility = const Icon(Icons.visibility_outlined,
            color: ColorManager.primaryColor);
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
        : iconVisibility2 = const Icon(Icons.visibility_outlined,
            color: ColorManager.primaryColor);
    emit(RegisterChangeIconVisibility2State());
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
