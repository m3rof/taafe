import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:taafe/modules/drawer_items/Diagnosis/diagnosis_screen.dart';
import 'package:taafe/modules/drawer_items/appointment/appointment_screen.dart';
import 'package:taafe/modules/drawer_items/my_therapists/my_therapists_screen.dart';
import 'package:taafe/modules/medical_record/mediacal_record_screen.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import 'package:taafe/shared/resourses/value_app.dart';

import '../../../modules/drawer_items/setting/setting_screen.dart';
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
            itemDrawer(context,Icons.medical_information,'Medical Record',(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicalRecordScreen(),));
            }),
            itemDrawer(context,FontAwesomeIcons.bell,'Medicine Alarm',(){}),
            itemDrawer(context,FontAwesomeIcons.heart,'Interests / Hobbies',(){}),
            itemDrawer(context,FontAwesomeIcons.calendarTimes,'Appointments',(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AppointmentScreen(),));
            }),
            itemDrawer(context,FontAwesomeIcons.diagnoses,'diagnosis',(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DiagnosisScreen(),));
            }),
            itemDrawer(context,FontAwesomeIcons.fileMedical,'My therapist',(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyTherapistsScreen(),));
            }),
            itemDrawer(context,Icons.settings,'Setting',(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen(),));
            }),


          ],
        ),
      ),
    );
  }
}
