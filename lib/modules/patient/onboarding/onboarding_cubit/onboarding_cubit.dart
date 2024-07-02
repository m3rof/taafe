import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/shared/components/constants.dart';



import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_points.dart';
import 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);


  List hobby = [];

  void getHobby() {
    DioHelper.getData(url: patientHobby, query: {'patientID': uId}).then((value) {
      hobby = value.data;
      emit(GetHobbySuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(GetHobbyErrorState());
    });
  }


  void sendHobby( String hobby) {
    DioHelper.postData(url: patientHobby, data: {
      'patientID': uId,
      'hobby': hobby,
    }).then((value) {
      print(value.data);
    }).catchError((Error) {
      print(Error.toString());
    });
  }

  void deleteHobby( hobbyID, String role) {
    DioHelper.deleteData(
      url: patientHobby,
      data: {'patientID': uId, 'hobbyID': hobbyID, 'role': role},
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
      sendHobby(value);

      emit(OnBoardingAddHobbyState());
    } else if (isSelected == false) {
      hobbyLocal.removeWhere((element) => element == value);
      deleteHobby(getHobbyID(value), 'patient');
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
