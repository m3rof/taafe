abstract class RegisterState{}
class RegisterInitialState extends RegisterState{}
class CheckValidatorRegisterState extends RegisterState{}
class CheckConfirmRegisterState extends RegisterState{}
class RegisterLoadingState extends RegisterState{}
class RegisterSuccessState extends RegisterState{}
class RegisterErrorState extends RegisterState{}
class AppChangePasswordVisibility extends RegisterState{}

class RegisterDateTimeState extends RegisterState{}
class RegisterOnClickedState extends RegisterState{}
class RegistergenderState extends RegisterState{}
class AppRegisterLoadingState extends RegisterState{}
class AppCreateUserSuccessState extends RegisterState{}
class AppRegisterErrorState extends RegisterState {
  final String error;
  AppRegisterErrorState(this.error);
}

class AppCreateUserLoadingState extends RegisterState {}



class AppCreateUserErrorState extends RegisterState {
  final String error;
  AppCreateUserErrorState(this.error);
}

class VerifyEmailLoadingState extends RegisterState {}

class VerifyEmailSuccessState extends RegisterState {}

class VerifyEmailErrorState extends RegisterState {
  final String error;
  VerifyEmailErrorState(this.error);
}



