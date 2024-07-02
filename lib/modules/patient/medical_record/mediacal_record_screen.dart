import 'package:awesome_icons/awesome_icons.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:taafe/modules/patient/medical_record/widgets/ListMedicine.dart';
import 'package:taafe/modules/patient/medical_record/widgets/add_diagnose.dart';
import 'package:taafe/modules/patient/medical_record/widgets/add_medicine_screen.dart';

import 'package:taafe/modules/patient/medical_record/widgets/divider_medical_record.dart';
import 'package:taafe/modules/patient/medical_record/widgets/list_diagnose.dart';
import 'package:taafe/modules/patient/medical_record/widgets/list_hobby.dart';
import 'package:taafe/modules/patient/medical_record/widgets/title.dart';
import 'package:taafe/modules/patient/onboarding/onboarding_screen.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import 'package:taafe/shared/widgets/input_Field.dart';

import '../../../models/patient_model/patient_main_info_model.dart';
import '../../../models/user_model/user_model.dart';
import '../../../shared/resourses/styles.dart';
import '../../../shared/resourses/value_app.dart';
import '../../../shared/widgets/app_btn.dart';
import 'medical_record_cubit/medical_record_cubit.dart';
import 'medical_record_cubit/medical_record_state.dart';

class MedicalRecordScreen extends StatefulWidget {
  MedicalRecordScreen({Key? key, required this.pateintMainModel})
      : super(key: key);
  PateintMainModel pateintMainModel;

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  late TextEditingController hobby;
  @override
  void initState() {
    hobby=TextEditingController();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    hobby.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = MedicalRecordCubit.get(context);
    DateTime dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(widget.pateintMainModel.birthDate);
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<MedicalRecordCubit, MedicalRecordState>(
          listener: (context, state) {
      if (state is MedicalRecordAddHobbySuccessState) {
        Fluttertoast.showToast(
          msg: "add success hobby!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: ColorManager.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context);
          }
      },
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
                              value: widget.pateintMainModel.name),
                          medicalRecordItem(
                              context: context,
                              icon: Icons.alternate_email_outlined,
                              title: 'Email: ',
                              value: widget.pateintMainModel.email),
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
                          TitleMedicalRecord(FontAwesomeIcons.smile, 'hobby',
                              () {
                            showModalBottomSheet(context: context, builder: (context){
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  textFieldEdit(hint: 'Enter your hobby', textEditingController: hobby, validator:'Enter your hobby', Icon:Icon(FontAwesomeIcons.smile)),
                                  AppBtn(
                                      label: "Add Hobby",
                                      onPressed: () {
                                        if (hobby.text.isEmpty) {
                                          Fluttertoast.showToast(
                                            msg: "Please Fill All Fields!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            backgroundColor: ColorManager.erroeColor,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        }else{
                                          cubit.createHobby(hobby.text);
                                        }
                                        }
                                      )
                                ],
                              );
                            } ,);
                          }),
                          ListHobby(cubit: cubit),
                          TitleMedicalRecord(
                              FontAwesomeIcons.fileMedical, 'diagnose', () {
                            moveScreen(context: context, screen: AddDiagnoseScreen());
                          }),
                          ListDiagnose(cubit: cubit),
                          DividerMedicalRecord(),
                          TitleMedicalRecord(
                              Icons.medical_services, 'Medicine', () {
                           moveScreen(context: context, screen: AddMedicineScreen());
                          }),
                          ListMedicine(cubit: cubit),
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

