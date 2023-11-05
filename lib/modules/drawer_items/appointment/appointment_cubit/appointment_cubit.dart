import 'package:awesome_icons/awesome_icons.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(AppointmentInitialState());

  static AppointmentCubit get(context) => BlocProvider.of(context);

  bool history=true;

  List colorSelected=[ColorManager.headOrange,ColorManager.textWhite];
  List colorUnSelected=[ColorManager.textWhite,ColorManager.primaryColor];

  void changeToTrue(){
    history=true;
    emit(AppointmentHistoryState());
  }

  void changeToFalse(){
    history=false;
    emit(AppointmentUpComingState());
  }

}
