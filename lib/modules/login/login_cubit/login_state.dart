import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class ChangeVisibilityState extends LoginState {}

class ChangeIconVisibilityState extends LoginState {}

class CheckValidatorLoginState extends LoginState {}

class NavigationRegisterState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final User user;
  final String? token;

  SuccessLoginState({required this.user,required this.token,});
}

class ErrorLoginState extends LoginState {
  final String error;

  ErrorLoginState({required this.error});
}
