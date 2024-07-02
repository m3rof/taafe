import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:taafe/shared/components/constants.dart';

import '../../../../models/patient_model/patient_info_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_points.dart';
import 'medical_record_state.dart';

class MedicalRecordCubit extends Cubit<MedicalRecordState> {
  MedicalRecordCubit() : super(MedicalRecordInitialState());

  static MedicalRecordCubit get(context) => BlocProvider.of(context);

  PatientInfoModel? patientInfoModel;

  void getPatientInfo() {
    DioHelper.getData(url: patientInfo, query: {'patientID': uId})
        .then((value) {
      patientInfoModel = PatientInfoModel.fromJson(value.data);
      emit(GetPatientInfoSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(GetPatientInfoErrorState());
    });
  }

  List hobby = [];

  void getHobby() {
    DioHelper.getData(url: patientHobby, query: {'patientID': uId})
        .then((value) {
      hobby = value.data;
      print(hobby);
      emit(MedicalRecordGetHobbySuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(MedicalRecordGetHobbyErrorState());
    });
  }

  void createHobby( String hobby) async{
    try{
      Response response=await   DioHelper.postData(
        url: patientHobby,
        data: {'patientID': uId, 'hobby': hobby},
      );
      print(response.data);
      emit(MedicalRecordAddHobbySuccessState());
    }catch (error){
      print(error.toString());
      emit(MedicalRecordAddHobbyErrorState(error.toString()));
    }
  }


  void deleteHobby(int hobbyID, String role,int index)async {
    try{
    Response response=await   DioHelper.deleteData(
        url: patientHobby,
        data: {'patientID': uId, 'hobbyID': hobbyID, 'role': role},
      );
      hobby.removeAt(index);
      print(response.data);
    emit(MedicalRecordDeleteHobbySuccessState());
    }catch (error){
      print(error.toString());
      emit(MedicalRecordDeleteHobbyErrorState(error.toString()));
    }
  }

  List diagnose = [];

  void getDiagnose() {
    DioHelper.getData(url: patientDiagnose, query: {'patientID': uId})
        .then((value) {
      diagnose = value.data;
      print(diagnose);
      emit(MedicalRecordGetDiagnoseSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(MedicalRecordGetDiagnoseErrorState());
    });
  }

  void deleteDiagnose(int diagnoseID, String role, int index) {
    try {
      DioHelper.deleteData(
          url: patientDiagnose,
          data: {'patientID': uId, 'diagnoseID': diagnoseID, 'role': role});
      diagnose.removeAt(index);
      emit(MedicalRecordDeleteDiagnoseSuccessState());
    } catch (error) {
      print('ddddddd ${error.toString()}');
      emit(MedicalRecordDeleteDiagnoseErrorState(error.toString()));
    }
  }

  void createDiagnose(
      String name, String doctorName, String date) {
    try {
      final response= DioHelper.postData(url: patientDiagnose, data: {
        'patientID': uId,
        'name': name,
        'doctorName': doctorName,
        'date': date,
      });
      emit(MedicalRecordCreateDiagnoseSuccessState());
    } catch (error) {
      print(error.toString());
      emit(MedicalRecordCreateDiagnoseErrorState(error.toString()));
    }
  }

  List medicine = [];

  void getMedicine() {
    DioHelper.getData(url: patientMedicine, query: {'patientID': uId})
        .then((value) {
      medicine = value.data;
      print(medicine);
      emit(MedicalRecordGetMedicineSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(MedicalRecordGetMedicineErrorState());
    });
  }

  void deleteMedicine(int medicineID, String role, int index) {
    try {
      DioHelper.deleteData(
          url: patientMedicine,
          data: {'patientID': uId, 'medicineID': medicineID, 'role': role});
      medicine.removeAt(index);
      emit(MedicalRecordDeleteMedicineSuccessState());
    } catch (error) {
      print('wwwwwwwwww ${error.toString()}');
      emit(MedicalRecordDeleteMedicineErrorState(error.toString()));
    }
  }

  void createMedicine (
      String name, String doctorName, String freq, String active,String startDate,String endDate) {
    try {
      final response= DioHelper.postData(url: patientMedicine, data: {
        'patientID': uId,
        'name': name,
        'doctorName': doctorName,
        'freq': freq,
        'active': active,
        'startDate':startDate,
        'endDate':endDate
      });
      emit(MedicalRecordCreateMedicineSuccessState());
    } catch (error) {
      print(error.toString());
      emit(MedicalRecordCreateMedicineErrorState(error.toString()));
    }
  }

  DateTime dateTime = DateTime.now();

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
    emit(MedicalPickDateState());
  }

  void showCalender({required context, required TextEditingController date}) {
    showSheet(context, buildDatePicker(), () {
      print(DateFormat('MM/dd/yyyy').format(dateTime));
      Navigator.pop(context);
      if (dateTime != null) {
        date.text = DateFormat('MM/dd/yyyy').format(dateTime);
      }
    });
    emit(HomeShowDateState());
  }

}
