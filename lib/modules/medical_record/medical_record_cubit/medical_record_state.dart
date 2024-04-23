abstract class MedicalRecordState{}
class MedicalRecordInitialState extends MedicalRecordState{}
class GetPatientMainSuccessState extends MedicalRecordState{}
class GetPatientMainErrorState extends MedicalRecordState{}

class GetPatientInfoSuccessState extends MedicalRecordState{}
class GetPatientInfoErrorState extends MedicalRecordState{}

class MedicalRecordGetHobbySuccessState extends MedicalRecordState{}
class MedicalRecordGetHobbyErrorState extends MedicalRecordState{}

class MedicalRecordAddHobbyState extends MedicalRecordState{}
class MedicalRecordDeleteHobbyState extends MedicalRecordState{}

class MedicalRecordGetDiagnoseSuccessState extends MedicalRecordState{}
class MedicalRecordGetDiagnoseErrorState extends MedicalRecordState{}

class MedicalRecordGetMedicineSuccessState extends MedicalRecordState{}
class MedicalRecordGetMedicineErrorState extends MedicalRecordState{}