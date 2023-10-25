import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';

import '../../shared/resourses/value_app.dart';

class MedicalRecordScreen extends StatelessWidget {
  const MedicalRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: SizeManager.s24, right: SizeManager.s22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: hightMedia(context: context, h: SizeManager.s_01),
                ),
                Row(
                  children: [
                    const Text(StringManager.medicalRecord),
                    const Spacer(),
                    blueContainer(
                        radius: SizeManager.s10, text: StringManager.edit)
                  ],
                ),
                const SizedBox(height: SizeManager.s20),
                medicalRecordItem(icon: FontAwesomeIcons.user, title: 'Name (Username):', value: 'MOHAMED  ZALATA (mohzalata22)'),
                medicalRecordItem(icon:Icons.alternate_email_outlined, title: 'Email: ', value: 'ABO ELHASAAN 123@gmail.com'),
                medicalRecordItem(icon: Icons.date_range_outlined, title: 'Date of Birth:', value: '15/10/1922'),
                medicalRecordItem(icon: FontAwesomeIcons.user, title: 'Following User:', value: 'MOHAMED ABDELGHAFOOR ZALATA'),
                medicalRecordItem(icon: FontAwesomeIcons.smile, title: 'Hobbies:', value: 'basketball     /      volly bal'),
                medicalRecordItem(icon: FontAwesomeIcons.hardHat, title: 'Education:', value: 'computer engineering Alex University'),
                medicalRecordItem(icon:  Icons.work, title: 'Experience:', value: 'Alaqsa factory Alula company'),
                medicalRecordItem(icon: FontAwesomeIcons.fileMedical, title: 'Diagnosis:', value: 'Depression Didorders (dr.Omar) Phobia (dr.Fawzi)'),
                medicalRecordItem(icon: FontAwesomeIcons.briefcaseMedical, title: 'Medicine:', value: 'Panadol extra Paxera'),
                medicalRecordItem(icon: FontAwesomeIcons.handHoldingMedical, title: 'Therapist:', value: 'Dr. Ahmed Helal')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
