
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  static final List<String> drugs = ['Yes', 'No'];
  var selectedItemDrugs;

  static final List<String> religious = ['Yes', 'No'];
  var selectedItemReligious;


  void showResult(value, String selectedItem) {
    selectedItem = value as String;
    emit(MyAccountDownFormState());
  }

  void checkValidation({required context,
    required GlobalKey<FormState> key,
    required TextEditingController heightController,
    required TextEditingController weightController}) {
    if (key.currentState!.validate()) {
      print(heightController.text);
      print(weightController.text);
      emit(MyAccountCheckValidatortate());
    }
  }
}
