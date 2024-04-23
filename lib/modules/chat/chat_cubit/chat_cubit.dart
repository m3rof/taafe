import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  List answer=[];

  void getAIChat(String message) {
    DioHelper.getData(url: AICaht, query: {'prompt': message}).then((
        value) {
      answer.add(value.data);
      print(answer);
      emit(ChatAISuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(ChatAIErrorState());
    });
  }


}
