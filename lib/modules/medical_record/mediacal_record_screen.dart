import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';

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
                medicalRecordItem(context: context,icon: FontAwesomeIcons.user, title: 'Name (Username):', value: 'MOHAMED  ZALATA (mohzalata22)'),
                medicalRecordItem(context: context,icon:Icons.alternate_email_outlined, title: 'Email: ', value: 'ABO ELHASAAN 123@gmail.com'),
                medicalRecordItem(context: context,icon: Icons.date_range_outlined, title: 'Date of Birth:', value: '15/10/1922'),
                medicalRecordItem(context: context,icon: FontAwesomeIcons.user, title: 'Following User:', value: 'MOHAMED ABDELGHAFOOR ZALATA'),
                medicalRecordItem(context: context,icon: FontAwesomeIcons.smile, title: 'Hobbies:', value: 'basketball     /      volly bal'),
                medicalRecordItem(context: context,icon: FontAwesomeIcons.hardHat, title: 'Education:', value: 'computer engineering Alex University'),
                medicalRecordItem(context: context,icon:  Icons.work, title: 'Experience:', value: 'Alaqsa factory Alula company'),
                medicalRecordItem(context: context,icon: FontAwesomeIcons.fileMedical, title: 'diagnosis:', value: 'Depression Didorders (dr.Omar) Phobia (dr.Fawzi)'),
                medicalRecordItem(context: context,icon: FontAwesomeIcons.briefcaseMedical, title: 'Medicine:', value: 'Panadol extra Paxera'),
                medicalRecordItem(context: context,icon: FontAwesomeIcons.handHoldingMedical, title: 'Therapist:', value: 'Dr. Ahmed Helal')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
