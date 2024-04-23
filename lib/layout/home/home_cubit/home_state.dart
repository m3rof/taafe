import '../../../models/patient_model/patient_main_info_model.dart';

abstract class HomeState{}
class HomeInitialState extends HomeState{}
class ChangePagesState extends HomeState{}

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
class GetDoctorMainErrorState extends HomeState{}





