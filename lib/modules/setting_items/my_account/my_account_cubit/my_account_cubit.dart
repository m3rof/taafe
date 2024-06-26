
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/models/doctor_models/doctor_main_model.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/network/remote/end_points.dart';

import '../../../../shared/network/remote/dio_helper.dart';
import 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  MyAccountCubit() : super(MyAccountInitialState());

  static MyAccountCubit get(context) => BlocProvider.of(context);

  static final List<String> bload = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  var selectedItemBload;

  static final List<String> martialStatus = [
    'single',
    'married',
    'widowed',
    'divorced',
    'separated '
  ];
  var selectedItemMartial;


  static final List<String> alcohol = ['Yes', 'No'];
  var selectedItemAlcohol;

  static final List<String> drugs = ['Yes','No'];
  var selectedItemDrugs;

  static final List<String> religious = ['Yes', 'No'];
  var selectedItemReligious;

  static final List<String> religion = ['Muslim', 'Christian','Jewish'];
  var selectedItemReligion;


  void showResultReligious(value) {
    emit(MyAccountInitialState());
    selectedItemReligious=value;
    emit(MyAccountDownFormState());
  }

  void showResultReligion(value) {
    emit(MyAccountInitialState());
    selectedItemReligion=value;
    emit(MyAccountDownFormState());
  }

  void showResultDrugs(value) {
    emit(MyAccountInitialState());
    selectedItemDrugs=value;
    emit(MyAccountDownFormState());
  }

  void showResultAlcohol(value) {
    emit(MyAccountInitialState());
    selectedItemAlcohol=value;
    emit(MyAccountDownFormState());
  }

  void showResultMartial(value) {
    emit(MyAccountInitialState());
    selectedItemMartial=value;
    emit(MyAccountDownFormState());
  }

  void showResultBload(value) {
    emit(MyAccountInitialState());
    selectedItemBload=value;
    emit(MyAccountDownFormState());
  }



  void checkValidation({required context,
    required GlobalKey<FormState> key,
    required TextEditingController heightController,
    required TextEditingController weightController}) {
    if (key.currentState!.validate()) {
      editPatientInfo(idPatient,heightController.text,weightController.text);
      emit(MyAccountCheckValidatortate());
    }
  }

  void editPatientInfo(String patientID,height,weight) {
    DioHelper.postData(url: patientInfo, data: {
      'patientID': patientID,
      'height': height,
      'weight': weight,
      'blood': selectedItemBload,
      'martialStatus': selectedItemMartial,
      'alcohol': selectedItemAlcohol=='Yes'?true:false,
      'drugs': selectedItemDrugs=='Yes'?true:false,
      'religious': selectedItemReligious=='Yes'?true:false,
      'religion': selectedItemReligion
    }).then((value) {
      print(value.data);
      emit(MyAccountSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(MyAccountErrorState());
    });
  }



}
