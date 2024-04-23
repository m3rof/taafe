import 'package:awesome_icons/awesome_icons.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/layout/home/home_cubit/home_cubit.dart';
import 'package:taafe/layout/home/home_cubit/home_state.dart';
import 'package:taafe/modules/medical_record/medical_record_cubit/medical_record_cubit.dart';
import 'package:taafe/modules/medical_record/medical_record_cubit/medical_record_state.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';

import '../../models/patient_model/patient_main_info_model.dart';
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
              condition: cubit.hobby.isNotEmpty &&
                  cubit.diagnose.isNotEmpty &&
                  cubit.medicine.isNotEmpty &&
                  cubit.patientInfoModel != null &&
                  dateTime != null,
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
                          medicalRecordListView(
                            context: context,
                            icon: FontAwesomeIcons.smile,
                            title: 'Hobbies:',
                            list: cubit.hobby,
                            widget: (index, list) => index == list.length - 1
                                ? Text('${list[index]['hobby']}',
                                    style: StylesManager.itemHome
                                        .copyWith(fontSize: SizeManager.s16))
                                : Text(
                                    '${list[index]['hobby']} / ',
                                    style: StylesManager.itemHome
                                        .copyWith(fontSize: SizeManager.s16),
                                  ),
                          ),
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
                          medicalRecordListView(
                            height: 45,
                            axis: Axis.vertical,
                            context: context,
                            icon: FontAwesomeIcons.fileMedical,
                            title: 'diagnosis:',
                            list: cubit.diagnose,
                            widget: (index, list) {
                              return Column(
                                children: [
                                  Text(
                                    'name: ${list[index]['name']}  doctor name: ${list[index]['doctorName']} auther: ${list[index]['auther']}',
                                    style: StylesManager.itemHome
                                        .copyWith(fontSize: SizeManager.s16),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            },
                          ),
                          medicalRecordListView(
                            context: context,
                            icon: FontAwesomeIcons.briefcaseMedical,
                            title: 'medicine:',
                            list: cubit.medicine,
                            widget: (index, list) {
                              return Text(
                                'name: ${list[0]['name']} doctor name: ${list[0]['doctorName']} auther: ${list[0]['auther']}',
                                style: StylesManager.itemHome
                                    .copyWith(fontSize: SizeManager.s16),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
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
