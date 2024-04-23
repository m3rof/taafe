import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/shared/network/remote/end_points.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import 'diagnosis_state.dart';

class DiagnosisCubit extends Cubit<DiagnosisState> {
  DiagnosisCubit() : super(DiagnosisInitialState());

  static DiagnosisCubit get(context) => BlocProvider.of(context);

  void sendDiagnosis(int patientID, String name,String doctorName,String date) {
    DioHelper.postData(url: patientDiagnose, data: {
      'patientID': patientID,
      'name': name,
      'doctorName': doctorName,
      'date':date
    }).then((value) {
      print(value.data);
      emit(SendDiagnosisSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(SendDiagnosisErrorState());
    });
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
    emit(DiagnosisPickDateState());
  }

  void showCalender({required context, required TextEditingController date}) {
    showSheet(context, buildDatePicker(), () {
      print(DateFormat('MM/dd/yyyy').format(dateTime));
      Navigator.pop(context);
      if (dateTime != null) {
        date.text = DateFormat('MM/dd/yyyy').format(dateTime);
      }
    });
    emit(DiagnosisShowDateState());
  }



}





