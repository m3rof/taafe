import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:taafe/shared/resourses/assets_manager.dart';

import '../../../shared/resourses/color_manager.dart';
import '../../../shared/resourses/styles.dart';
import '../../../shared/resourses/value_app.dart';


import '../chat_cubit/chat_cubit.dart';
import '../widgets/recieve_message.dart';
import '../widgets/send_message.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({Key? key}) : super(key: key);
  static String routeName='AIChat';

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
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
      appBar: AppBar(
        title: Text('AI Chat',style: TextStyle(color: ColorManager.primaryColor)),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return Container(
            height: double.infinity,
            child: Column(
              children: [
                cubit.answer.length != 0
                    ? Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return index % 2 == 0
                            ? SendMessage(cubit.answer[index])
                            : ReciveMessage(cubit.answer[index]);
                      },
                      itemCount: cubit.answer.length,
                    ))
                    : Expanded(
                      child: Column(
                                        children: [
                      Image(
                        image: AssetImage(AssetsManager.logo),
                        width: 180,
                        height: 180,
                      ),
                      Text(
                        'How can I help you today',
                        style: TextStyle(
                            color: ColorManager.headBlack,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                                        ],
                                      ),
                    ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: message,
                       style: StylesManager.itemHome,
                      onSubmitted: (value) {
                        cubit.getAIChat(message.text).then((_){
                          message.text = '';
                        });
                      },
                      decoration: InputDecoration(
                        suffix: InkWell(
                          onTap: () {
                            cubit.getAIChat(message.text).then((value){
                              message.text = '';
                            });

                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: 'Enter your message..',
                        hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(SizeManager.s30)),
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(SizeManager.s30)),
                            borderSide: BorderSide(color: Colors.transparent)),
                        // prefixIcon: prefixIcon,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
