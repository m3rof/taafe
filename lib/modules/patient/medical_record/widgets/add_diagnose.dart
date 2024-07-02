import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taafe/layout/home/home_cubit/home_cubit.dart';
import 'package:taafe/layout/home/home_cubit/home_state.dart';
import 'package:taafe/modules/edit_profile/edit_widgets/edit_widgets.dart';
import 'package:taafe/modules/patient/medical_record/medical_record_cubit/medical_record_cubit.dart';
import 'package:taafe/modules/patient/medical_record/medical_record_cubit/medical_record_state.dart';

import 'package:taafe/shared/network/remote/end_points.dart';
import 'package:taafe/shared/resourses/value_app.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/resourses/color_manager.dart';
import '../../../../shared/resourses/styles.dart';

class AddDiagnoseScreen extends StatefulWidget {
  @override
  State<AddDiagnoseScreen> createState() => _AddDiagnoseScreenState();
}

class _AddDiagnoseScreenState extends State<AddDiagnoseScreen> {
  late TextEditingController name;
  late TextEditingController doctorName;
  late TextEditingController date;

  @override
  void initState() {
    name = TextEditingController();
    doctorName = TextEditingController();
    date = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<MedicalRecordCubit, MedicalRecordState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MedicalRecordCubit.get(context);
          return ListView(
            padding: EdgeInsets.symmetric(
                horizontal: SizeManager.s20, vertical: SizeManager.s16),
            children: [
              Text(
                'add medicine',
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              textFieldEdit(
                  hint: 'name',
                  textEditingController: name,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter your name'),
              SizedBox(
                height: SizeManager.s40,
              ),
              textFieldEdit(
                  hint: 'doctorName',
                  textEditingController: doctorName,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter doctorName'),
              SizedBox(
                height: SizeManager.s40,
              ),
              dateEdit(date, 'date', () {
                cubit.showCalender(context: context, date: date);
              }),
              SizedBox(
                height: SizeManager.s40,
              ),
              ElevatedButton(
                onPressed: () {
                  cubit.createDiagnose(name.text, doctorName.text, date.text);
                  Navigator.pop(context);
                },
                child: Text('Create Diagnose',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeManager.s12)), // <-- Radius
                  ),
                  backgroundColor: ColorManager.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: SizeManager.s16),
                ),
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
            ],
          );
        },
      ),
    );
  }
}
