

abstract class HomeState{}
class HomeInitialState extends HomeState{}
class ChangePagesState extends HomeState{}

class DeleteAccountSuccessState extends HomeState{}
class DeleteAccountErrorState extends HomeState{
  final String error;
  DeleteAccountErrorState(this.error);
}

class GetPatientMainSuccessState extends HomeState{}
class GetPatientMainErrorState extends HomeState{}

class GetPatientInfoSuccessState extends HomeState{}
class GetPatientInfoErrorState extends HomeState{}

class HomePickImageState extends HomeState{}

class HomePickDateState extends HomeState{}
class HomeShowDateState extends HomeState{}

class HomeGetHobbySuccessState extends HomeState{}
class HomeGetHobbyErrorState extends HomeState{}
class HomeAddHobbyState extends HomeState{}
class HomeDeleteHobbyState extends HomeState{}
class HomeGetDiagnoseSuccessState extends HomeState{}
class HomeGetDiagnoseErrorState extends HomeState{}
class HomeGetMedicineSuccessState extends HomeState{}
class HomeGetMedicineErrorState extends HomeState{}



class GetDoctorMainSuccessState extends HomeState{}
class GetDoctorMainErrorState extends HomeState{
  final String error;
  GetDoctorMainErrorState(this.error);
}

class EditDoctorNameSuccessState extends HomeState{}
class EditDoctorNameErrorState extends HomeState{
  final String error;
  EditDoctorNameErrorState(this.error);
}

class EditDoctorTitleSuccessState extends HomeState{}
class EditDoctorTitleErrorState extends HomeState{
  final String error;
  EditDoctorTitleErrorState(this.error);
}

class EditDoctorBirthDateSuccessState extends HomeState{}
class EditDoctorBirthDateErrorState extends HomeState{
  final String error;
  EditDoctorBirthDateErrorState(this.error);
}

class EditDoctorProfileImageSuccessState extends HomeState{}
class EditDoctorProfileImageErrorState extends HomeState{
  final String error;
  EditDoctorProfileImageErrorState(this.error);
}

class EditDoctorDescriptionSuccessState extends HomeState{}
class EditDoctorDescriptionErrorState extends HomeState{
  final String error;
  EditDoctorDescriptionErrorState(this.error);
}

class EditDoctorEducationSuccessState extends HomeState{}
class EditDoctorEducationErrorState extends HomeState{
  final String error;
  EditDoctorEducationErrorState(this.error);
}

class EditDoctorExperinceSuccessState extends HomeState{}
class EditDoctorExperinceErrorState extends HomeState{
  final String error;
  EditDoctorExperinceErrorState(this.error);
}

class EditDoctorCertificateSuccessState extends HomeState{}
class EditDoctorCertificateErrorState extends HomeState{
  final String error;
  EditDoctorCertificateErrorState(this.error);
}



class PickProfilePicSuccessState extends HomeState{}
class PickProfilePicErrorState extends HomeState{
  final String error;
  PickProfilePicErrorState(this.error);
}

class UploadProfilePicSuccessState extends HomeState{}
class UploadProfilePicErrorState extends HomeState{
  final String error;
  UploadProfilePicErrorState(this.error);
}

class SetProfileImageSuccessState extends HomeState{}
class SetProfileImageErrorState extends HomeState{
  final String error;
  SetProfileImageErrorState(this.error);
}




class EditPatientNameSuccessState extends HomeState{}
class EditPatientNameErrorState extends HomeState{
  final String error;
  EditPatientNameErrorState(this.error);
}

class EditPatientLanguageSuccessState extends HomeState{}
class EditPatientLanguageErrorState extends HomeState{
  final String error;
  EditPatientLanguageErrorState(this.error);
}

class EditPatientBirthDateSuccessState extends HomeState{}
class EditPatientBirthDateErrorState extends HomeState{
  final String error;
  EditPatientBirthDateErrorState(this.error);
}

class EditPatientProfileImageSuccessState extends HomeState{}
class EditPatientProfileImageErrorState extends HomeState{
  final String error;
  EditPatientProfileImageErrorState(this.error);
}

class ChangeLanguage extends HomeState{}

