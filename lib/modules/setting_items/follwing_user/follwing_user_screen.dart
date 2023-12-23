import 'package:flutter/material.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import '../../../shared/resourses/value_app.dart';

class FollwingUser extends StatefulWidget {
  const FollwingUser({Key? key}) : super(key: key);

  @override
  State<FollwingUser> createState() => _FollwingUserState();
}

class _FollwingUserState extends State<FollwingUser> {
  late TextEditingController userName;
  late TextEditingController relationship;

  @override
  void initState() {
    userName = TextEditingController();
    relationship = TextEditingController();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    userName.dispose();
    relationship.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: SizeManager.s24, right: SizeManager.s22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Following User'),
              SizedBox(
                height: hightMedia(context: context, h: SizeManager.s_05),
              ),
              collectionTextFormGrey(
                  title: 'Username:',
                  textEditingController: userName,
                  validator: 'enter your name',
                  textInputType: TextInputType.text,
                  left: SizeManager.s10,
                  right: SizeManager.s10,
                  top: SizeManager.s10,
                  bottom: SizeManager.s10),
              collectionTextFormGrey(
                  title: 'Relationship:',
                  textEditingController: relationship,
                  validator: 'enter the relationship',
                  textInputType: TextInputType.text,
                  left: SizeManager.s10,
                  right: SizeManager.s10,
                  top: SizeManager.s10,
                  bottom: SizeManager.s10),
              SizedBox(
                height: hightMedia(context: context, h: SizeManager.s_05),
              ),
              Align(alignment: Alignment.center,child: ElevatedButton(onPressed: (){}, child:const Text('Scan QR',style: TextStyle(fontSize: SizeManager.s18,color: ColorManager.textWhite),))),
              SizedBox(
                height: hightMedia(context: context, h: SizeManager.s_07),
              ),
              Align(alignment: Alignment.center,child: ElevatedButton(onPressed: (){}, child:const Text('Send Code',style: TextStyle(fontSize: SizeManager.s18,color: ColorManager.textWhite)),)),

            ],
          ),
        ),
      ),
    );
  }
}
