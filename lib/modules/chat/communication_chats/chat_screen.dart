import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/models/chat_models/chat_messages_model.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';


import '../../../shared/resourses/color_manager.dart';
import '../../../shared/resourses/styles.dart';
import '../../../shared/resourses/value_app.dart';
import '../chat_cubit/chat_cubit.dart';
import '../widgets/recieve_message.dart';
import '../widgets/send_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _AIChatState();
}

class _AIChatState extends State<ChatScreen> {
  late TextEditingController message;

  @override
  void initState() {
    // TODO: implement initState
    message = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return StreamBuilder<QuerySnapshot<ChatMessgesModel>>(
            stream: cubit.getChat('a4Pw7N6mo8cq3xzVrz2U'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              var chatMessage = snapshot.data?.docs.reversed.map((docs) =>
                  docs.data()).toList();
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemBuilder: (context, index) {
                          return chatMessage[index].senderSide=='patient'?SendMessage(chatMessage[index].text):ReciveMessage(chatMessage[index].text);
                        },
                        itemCount: chatMessage!.length,
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: message,
                        style: StylesManager.itemHome,
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap:() => cubit.sendMessage('a4Pw7N6mo8cq3xzVrz2U', 'patient', message.text),
                            child: Icon(
                              Icons.send,color: Colors.black,),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: 'Enter your message..',
                          hintStyle: TextStyle(color: ColorManager.greyColor),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(SizeManager.s30)),
                              borderSide: BorderSide(color: Colors.transparent)),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(SizeManager.s30)),
                              borderSide: BorderSide(color: Colors.transparent)),
                          // prefixIcon: prefixIcon,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },);
        },
      ),
    );
  }
}



