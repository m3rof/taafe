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


class AddMedicineScreen extends StatefulWidget {





  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  late TextEditingController name;
  late TextEditingController doctorName;
  late TextEditingController freq;
  late TextEditingController active;
  late TextEditingController startDate;
  late TextEditingController endDate;

  @override
  void initState() {
    name=TextEditingController();
    doctorName=TextEditingController();
    freq=TextEditingController();
    active=TextEditingController();
    startDate = TextEditingController();
    endDate = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
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
              dateEdit(startDate, 'startDate', () {
                cubit.showCalender(context: context, date: startDate);
              }),
              SizedBox(
                height: SizeManager.s40,
              ),
              dateEdit(endDate, 'endDate', () {
                cubit.showCalender(context: context, date: endDate);
              }),
              SizedBox(
                height: SizeManager.s40,
              ),
              textFieldEdit(
                  hint: 'freq',
                  textEditingController: freq,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter  freq'),
              SizedBox(
                height: SizeManager.s40,
              ),
              textFieldEdit(
                  hint: 'active',
                  textEditingController: active,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter  active'),
              SizedBox(
                height: SizeManager.s40,
              ),
              dividerBlue(
                width: 200,
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              ElevatedButton(
                onPressed: () {
                  cubit.createMedicine(name.text, doctorName.text, freq.text, active.text, startDate.text, endDate.text);
                  Navigator.pop(context);
                },
                child: Text('Create Medicine',
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
