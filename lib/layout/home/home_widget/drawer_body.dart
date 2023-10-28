import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import 'package:taafe/shared/resourses/value_app.dart';

import '../../../modules/setting/setting_screen.dart';
import '../../../shared/components/components.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: widthMedia(context: context, x: SizeManager.s_7),
      child:
      Padding(
        padding: const EdgeInsets.only(left:SizeManager.s18,right:SizeManager.s18 ,top: SizeManager.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const Align(
                alignment: Alignment.center,
                child: SizedBox(
                    width: SizeManager.s150,
                    height: SizeManager.s150,
                    child: Image(image: AssetImage(AssetsManager.logo)))),
            const SizedBox(height: SizeManager.s10,),
            const Text(StringManager.accountProfile),
            const SizedBox(height: SizeManager.s35,),
            itemDrawer(context,FontAwesomeIcons.facebookMessenger,'chat',(){}),
            itemDrawer(context,Icons.medical_information,'Medical Record',(){}),
            itemDrawer(context,FontAwesomeIcons.bell,'Medicine Alarm',(){}),
            itemDrawer(context,FontAwesomeIcons.heart,'Interests / Hobbies',(){}),
            itemDrawer(context,FontAwesomeIcons.calendarTimes,'Appointments',(){}),
            itemDrawer(context,FontAwesomeIcons.diagnoses,'Diagnosis',(){}),
            itemDrawer(context,FontAwesomeIcons.fileMedical,'My therapist',(){}),
            itemDrawer(context,Icons.settings,'Setting',(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen(),));
            }),


          ],
        ),
      ),
    );
  }
}
