import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/shared/components/constants.dart';

import '../../../models/patient_model/patient_info_model.dart';
import '../../../models/patient_model/patient_main_info_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';
import 'medical_record_state.dart';

class MedicalRecordCubit extends Cubit<MedicalRecordState> {
  MedicalRecordCubit() : super(MedicalRecordInitialState());

  static MedicalRecordCubit get(context) => BlocProvider.of(context);




  PatientInfoModel? patientInfoModel;

  void getPatientInfo() {
    DioHelper.getData(url: patientInfo, query: {'patientID': idPatient}).then((value) {
      patientInfoModel = PatientInfoModel.fromJson(value.data);
      emit(GetPatientInfoSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(GetPatientInfoErrorState());
    });
  }

  List hobby=[];

  void getHobby() {
    DioHelper.getData(url: patientHobby, query: {'patientID': idPatient}).then((
        value) {
      hobby = value.data;
      print(hobby);
      emit(MedicalRecordGetHobbySuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(MedicalRecordGetHobbyErrorState());
    });
  }


  void deleteHobby(int patientID, int hobbyID, String role) {
    DioHelper.deleteData(
      url: patientHobby,
      data: {'patientID': patientID, 'hobbyID': hobbyID, 'role': role},
    ).then((value) {
      print(value.data);
    }).catchError((Error) {
      print(Error.toString());
    });
  }

  List diagnose = [];
  void getDiagnose() {
    DioHelper.getData(url: patientDiagnose, query: {'patientID': idPatient}).then((
        value) {
      diagnose = value.data;
      print(diagnose);
      emit(MedicalRecordGetDiagnoseSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(MedicalRecordGetDiagnoseErrorState());
    });
  }

  List medicine = [];

  void getMedicine() {
    DioHelper.getData(url: patientMedicine, query: {'patientID': idPatient}).then((
        value) {
      medicine = value.data;
      print(medicine);
      emit(MedicalRecordGetMedicineSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(MedicalRecordGetMedicineErrorState());
    });
  }


}





