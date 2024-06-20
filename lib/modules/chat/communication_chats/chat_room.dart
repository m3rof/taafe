import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/models/chat_models/chat_room_models.dart';
import 'package:taafe/modules/chat/chat_cubit/chat_cubit.dart';
import 'package:taafe/modules/chat/communication_chats/chat_screen.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';

import '../widgets/chat_room_widget.dart';




class ChatRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text(
          'Inbox',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return StreamBuilder<QuerySnapshot<ChatRoomModel>>(
            stream: cubit.getChatRooms(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              var chatRooms = snapshot.data?.docs.reversed.map((docs) =>
                  docs.data()).toList();
              return ListView.builder(
                 itemBuilder: (context, index) {
                return ChatRoomsWidget(nameSender:chatRooms!.elementAt(index).doctorName,lastMessage: chatRooms!.elementAt(index).last_d_message,function: (){
                  cubit.makeSeen('${snapshot.data!.docs.reversed.elementAt(index).id}', 'patient');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(),));
                },);
              }, itemCount: chatRooms?.length ?? 0,);
            },)
          ;
        },
      ),
    );
  }
}

