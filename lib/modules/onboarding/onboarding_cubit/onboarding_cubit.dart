import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/layout/home/home_cubit/home_cubit.dart';

import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';
import 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);


  List hobby = [];

  void getHobby() {
    DioHelper.getData(url: patientHobby, query: {'patientID': 1}).then((value) {
      hobby = value.data;
      emit(GetHobbySuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(GetHobbyErrorState());
    });
  }


  void sendHobby(int patientID, String hobby) {
    DioHelper.postData(url: patientHobby, data: {
      'patientID': patientID,
      'hobby': hobby,
    }).then((value) {
      print(value.data);
    }).catchError((Error) {
      print(Error.toString());
    });
  }

  void deleteHobby(int patientID, hobbyID, String role) {
    DioHelper.deleteData(
      url: patientHobby,
      data: {'patientID': patientID, 'hobbyID': hobbyID, 'role': role},
    ).then((value) {
      print('dddddddddddddone');
      print(value.data);
    }).catchError((Error) {
      print(Error.toString());
      print('ddddddddddddd');
    });
  }

  List<String> hobbyLocal = [];

  void hobbyList(String value, bool isSelected) {
    if (isSelected) {
      sendHobby(1,value);

      emit(OnBoardingAddHobbyState());
    } else if (isSelected == false) {
      hobbyLocal.removeWhere((element) => element == value);
      deleteHobby(1,getHobbyID(value), 'patient');
    }
  }

  int hobbyID=-1;

  int getHobbyID(String value) {
    getHobby();
    for(var n in hobby){
      emit(GetHobbyIDState());
      if(value==n['hobby']){
        hobbyID=n['id'];
        return hobbyID;
      }
    }
    return hobbyID;
  }
}
