import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:meta/meta.dart';
import 'package:taafe/models/chat_models/chat_messages_model.dart';
import 'package:taafe/models/chat_models/chat_room_models.dart';

import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_points.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);



  CollectionReference<ChatRoomModel> getChatRoomsCollection() {
    return FirebaseFirestore.instance.collection('chatrooms').withConverter(
      fromFirestore: (snapshot, _) => ChatRoomModel.fromjson(snapshot.data()!),
      toFirestore: (Message, options) => Message.tojson(),
    );
  }

  Stream<QuerySnapshot<ChatRoomModel>> getChatRooms() {
    return getChatRoomsCollection().snapshots();
  }

  CollectionReference<ChatMessgesModel> getChatCollection(String doc_id) {
    return FirebaseFirestore.instance.collection('chatrooms').doc(doc_id).collection('messages').withConverter(
      fromFirestore: (snapshot, _) => ChatMessgesModel.fromjson(snapshot.data()!),
      toFirestore: (Message, options) => Message.tojson(),
    );
  }

  Stream<QuerySnapshot<ChatMessgesModel>> getChat(String doc_id) {
    return getChatCollection(doc_id).orderBy('sendDate').snapshots();
  }


  void sendMessage(String chatroomID,String senderRole,String text) {
    DioHelper.postData(url: sendMessageEnd, data: {'chatroomID': chatroomID,'senderRole':senderRole,'text':text}).then((
        value) {
      print(value.data);
      emit(SendMessageSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(SendMessageErrorState());
    });
  }

  void makeSeen(String chatroomID,String senderRole) {
    DioHelper.postData(url: makeSeenEnd, data: {'chatroomID': chatroomID,'role':senderRole}).then((
        value) {
      print('chat id : $chatroomID');
      print(value.data);
      emit(MakeSeenSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(MakeSeenErrorState());
    });
  }



  List answer = [];

  String apiKey = 'AIzaSyBtCoMiin6alIxKH3TO0BD3hUZajy2SW-s';

  Future<void> getAIChat(String message) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
    final prompt = message;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    print(response.text);
    answer.add(message);
    answer.add(response.text);
    emit(ChatAISuccessState());
  }
}



