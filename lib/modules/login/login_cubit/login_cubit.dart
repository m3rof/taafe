
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/modules/login/login_cubit/login_state.dart';
import 'package:taafe/modules/register/register_screen.dart';
import 'package:taafe/shared/components/components.dart';


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

  void loginUser(context, String email, String password) async {
    emit(LoadingLoginState());
    try {
      final credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
      emit(SuccessLoginState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialogAwsome(context, 'No user found for that email.', DialogType.error,(){});
      } else if (e.code == 'wrong-password') {
        showDialogAwsome(context, 'Wrong password provided for that user.', DialogType.error,(){});
      }
      print('eeeeee ${e.message}');
      emit(ErrorLoginState());
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }



}
