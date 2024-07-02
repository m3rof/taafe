abstract class MedicalRecordState{}
class MedicalRecordInitialState extends MedicalRecordState{}
class GetPatientMainSuccessState extends MedicalRecordState{}
class GetPatientMainErrorState extends MedicalRecordState{}

class GetPatientInfoSuccessState extends MedicalRecordState{}
class GetPatientInfoErrorState extends MedicalRecordState{}

class MedicalRecordGetHobbySuccessState extends MedicalRecordState{}
class MedicalRecordGetHobbyErrorState extends MedicalRecordState{}

class MedicalRecordAddHobbySuccessState extends MedicalRecordState{}
class MedicalRecordAddHobbyErrorState extends MedicalRecordState{
  String error;

  MedicalRecordAddHobbyErrorState(this.error);
}

class MedicalRecordDeleteHobbySuccessState extends MedicalRecordState{}
class MedicalRecordDeleteHobbyErrorState extends MedicalRecordState{
  String error;

  MedicalRecordDeleteHobbyErrorState(this.error);
}

class MedicalRecordGetDiagnoseSuccessState extends MedicalRecordState{}
class MedicalRecordGetDiagnoseErrorState extends MedicalRecordState{}

class MedicalRecordCreateDiagnoseSuccessState extends MedicalRecordState{}
class MedicalRecordCreateDiagnoseErrorState extends MedicalRecordState{
  final String error;
  MedicalRecordCreateDiagnoseErrorState(this.error);
}

class MedicalRecordDeleteDiagnoseSuccessState extends MedicalRecordState{}
class MedicalRecordDeleteDiagnoseErrorState extends MedicalRecordState{
  final String error;
  MedicalRecordDeleteDiagnoseErrorState(this.error);
}

class MedicalRecordGetMedicineSuccessState extends MedicalRecordState{}
class MedicalRecordGetMedicineErrorState extends MedicalRecordState{}

class MedicalRecordDeleteMedicineSuccessState extends MedicalRecordState{}
class MedicalRecordDeleteMedicineErrorState extends MedicalRecordState{
  final String error;
  MedicalRecordDeleteMedicineErrorState(this.error);
}

class MedicalRecordCreateMedicineSuccessState extends MedicalRecordState{}
class MedicalRecordCreateMedicineErrorState extends MedicalRecordState{
  final String error;
  MedicalRecordCreateMedicineErrorState(this.error);
}

class MedicalPickDateState extends MedicalRecordState{}
class HomeShowDateState extends MedicalRecordState{}