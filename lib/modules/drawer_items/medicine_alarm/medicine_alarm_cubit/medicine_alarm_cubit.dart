
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'medicine_alarm_state.dart';

class MedicineAlarmCubit extends Cubit<MedicineAlarmState> {
  MedicineAlarmCubit() : super(MedicineAlarmInitialState());

  static MedicineAlarmCubit get(context) => BlocProvider.of(context);

  static final List<String> alarm = [
    'Set a alarm'
  ];
  String selectedItemAlarm=alarm[0];

  void showResult(value, String selectedItem) {
    selectedItem = value as String;
    emit(MedicineAlarmDownFormState());
  }

  static List<MedicineAlarm> medicineAlarm = [
    MedicineAlarm('Paxera Medicine',true,'5:00 pm','every day')
  ];

  changeTurn(){
    medicineAlarm[0].turn=! medicineAlarm[0].turn;
    emit(MedicineAlarmTurnState());
  }
}

class MedicineAlarm{
  String name;
  bool turn;
  String clock;
  String day;
  MedicineAlarm(this.name, this.turn, this.clock, this.day);
}
