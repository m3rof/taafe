import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/modules/chat/chat_cubit/chat_cubit.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';

import '../../shared/resourses/color_manager.dart';
import '../../shared/resourses/styles.dart';
import '../../shared/resourses/value_app.dart';

class AIChat extends StatefulWidget {
  const AIChat({Key? key}) : super(key: key);

  @override
  State<AIChat> createState() => _AIChatState();
}

class _AIChatState extends State<AIChat> {
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
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  cubit.answer.length!=0?
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) {
                     return index%2==0?SendMessage(cubit.answer[index]):ReciveMessage(cubit.answer[index]);
                    },
                    itemCount: cubit.answer.length,
                  )):Column(
                    children: [
                      Image(image: AssetImage(AssetsManager.logo),width: 200,height: 200,),
                      SizedBox(height: 14,),
                      Text('How can I help you today',style: TextStyle(color: ColorManager.headBlack,fontSize: 24,fontWeight: FontWeight.w500),)
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: message,
                    style: StylesManager.itemHome,
                    decoration: InputDecoration(
                      suffix: InkWell(
                        onTap: () => cubit.getAIChat(message.text),
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
        },
      ),
    );
  }
}

class SendMessage extends StatelessWidget {
  String message;

  SendMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 15,
              ),
              SizedBox(width: 15),
              CircleAvatar(
                  radius: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Image.network(
                        'https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=1541'),
                  ))            ],
          ),
          SizedBox(
            height: 4,
          ),
          Container(
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  color: ColorManager.greenColor),
              child: Text(
                message,
                style: TextStyle(color: Colors.white,fontSize: 22),
              )),
        ],
      ),
    );
  }
}

class ReciveMessage extends StatelessWidget {
  String message;

  ReciveMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Image.network(
                        'https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=1541'),
                  )),
              SizedBox(
                width: 15,
              ),
              SizedBox(width: 15),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Container(
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(30)),
                  color: Colors.grey[300]),
              child: Text(
                message,
                style: TextStyle(color: Colors.black,fontSize: 22),
              )),
        ],
      ),
    );
    ;
  }
}
