import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import 'package:taafe/shared/resourses/value_app.dart';

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
            itemDrawer(FontAwesomeIcons.facebookMessenger,'chat',(){}),
            itemDrawer(Icons.medical_information,'Medical Record',(){}),
            itemDrawer(FontAwesomeIcons.bell,'Medicine Alarm',(){}),
            itemDrawer(FontAwesomeIcons.heart,'Interests / Hobbies',(){}),
            itemDrawer(FontAwesomeIcons.calendarTimes,'Appointments',(){}),
            itemDrawer(FontAwesomeIcons.diagnoses,'Diagnosis',(){}),
            itemDrawer(FontAwesomeIcons.fileMedical,'My therapist',(){}),
            itemDrawer(Icons.settings,'Setting',(){}),


          ],
        ),
      ),
    );
  }
}
