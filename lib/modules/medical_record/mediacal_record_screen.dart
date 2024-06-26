import 'package:awesome_icons/awesome_icons.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/layout/home/home_cubit/home_cubit.dart';
import 'package:taafe/layout/home/home_cubit/home_state.dart';
import 'package:taafe/modules/medical_record/medical_record_cubit/medical_record_cubit.dart';
import 'package:taafe/modules/medical_record/medical_record_cubit/medical_record_state.dart';
import 'package:taafe/modules/medical_record/widgets/divider_medical_record.dart';
import 'package:taafe/modules/medical_record/widgets/title.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';

import '../../models/patient_model/patient_main_info_model.dart';
import '../../shared/resourses/color_manager.dart';
import '../../shared/resourses/styles.dart';
import '../../shared/resourses/value_app.dart';

class MedicalRecordScreen extends StatelessWidget {
  MedicalRecordScreen({Key? key, required this.pateintMainModel})
      : super(key: key);
  PateintMainModel pateintMainModel;

  @override
  Widget build(BuildContext context) {
    var cubit = MedicalRecordCubit.get(context);
    DateTime dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(pateintMainModel.birthDate);
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<MedicalRecordCubit, MedicalRecordState>(
          listener: (context, state) {},
          builder: (context, state) => ConditionalBuilder(
              condition: true,
              builder: (context) => SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: SizeManager.s24, right: SizeManager.s22),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: hightMedia(
                                context: context, h: SizeManager.s_01),
                          ),
                          Row(
                            children: [
                              const Text(StringManager.medicalRecord),
                              const Spacer(),
                              blueContainer(
                                  radius: SizeManager.s10,
                                  text: StringManager.edit)
                            ],
                          ),
                          const SizedBox(height: SizeManager.s20),
                          medicalRecordItem(
                              context: context,
                              icon: FontAwesomeIcons.user,
                              title: 'Name (Username):',
                              value: pateintMainModel!.name),
                          medicalRecordItem(
                              context: context,
                              icon: Icons.alternate_email_outlined,
                              title: 'Email: ',
                              value: pateintMainModel!.email),
                          medicalRecordItem(
                              context: context,
                              icon: Icons.date_range_outlined,
                              title: 'Date of Birth:',
                              value: DateFormat('MM/dd/yyyy').format(dateTime)),
                          medicalRecordItem(
                              context: context,
                              icon: FontAwesomeIcons.user,
                              title: 'Following User:',
                              value: 'MOHAMED ABDELGHAFOOR ZALATA'),

                          TitleMedicalRecord(FontAwesomeIcons.smile, 'hobby'),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cubit.hobby.length,
                            itemBuilder: (context, index) => index ==
                                    cubit.hobby.length - 1
                                ? Text('${cubit.hobby[index]['hobby']}',
                                    style: StylesManager.itemHome
                                        .copyWith(fontSize: SizeManager.s16),
                              textAlign: TextAlign.center,

                            )
                                : Text(
                                    '${cubit.hobby[index]['hobby']} / ',
                                    style: StylesManager.itemHome
                                        .copyWith(fontSize: SizeManager.s16),
                              textAlign: TextAlign.center,

                            ),
                          ),
                          DividerMedicalRecord(),

                          medicalRecordItem(
                              context: context,
                              icon: FontAwesomeIcons.hardHat,
                              title: 'Education:',
                              value: 'computer engineering Alex University'),
                          medicalRecordItem(
                              context: context,
                              icon: Icons.work,
                              title: 'Experience:',
                              value: 'Alaqsa factory Alula company'),
                          TitleMedicalRecord(
                              FontAwesomeIcons.fileMedical, 'diagnosis'),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cubit.diagnose.length,
                            itemBuilder: (context, index) {
                              return Text(
                                'name: ${cubit.diagnose[index]['name']} doctor name: ${cubit.diagnose[index]['doctorName']} auther: ${cubit.diagnose[index]['auther']}',
                                style: StylesManager.itemHome
                                    .copyWith(fontSize: SizeManager.s16),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                          DividerMedicalRecord(),
                          TitleMedicalRecord(
                              Icons.medical_services, 'Medicine'),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Text(
                                'name: ${cubit.medicine[index]['name']} doctor name: ${cubit.medicine[index]['doctorName']} auther: ${cubit.medicine[index]['auther']}',
                                style: StylesManager.itemHome
                                    .copyWith(fontSize: SizeManager.s16),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                          DividerMedicalRecord(),
                          medicalRecordItem(
                              context: context,
                              icon: FontAwesomeIcons.handHoldingMedical,
                              title: 'Therapist:',
                              value: 'Dr. Ahmed Helal')
                        ],
                      ),
                    ),
                  ),
              fallback: (context) => loadingProgress())),
    );
  }
}
