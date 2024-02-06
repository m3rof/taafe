import 'package:flutter/material.dart';
import 'package:taafe/shared/resourses/color_manager.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/resourses/value_app.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({Key? key}) : super(key: key);

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  late TextEditingController disease;
  late TextEditingController therapist;
  late TextEditingController date;
  late TextEditingController perscription;

  @override
  void initState() {
    disease = TextEditingController();
    therapist = TextEditingController();
    date = TextEditingController();
    perscription = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    disease.dispose();
    therapist.dispose();
    date.dispose();
    perscription.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: SizeManager.s24, right: SizeManager.s22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'diagnosis',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: SizeManager.s28),
              ),
              SizedBox(
                height: hightMedia(context: context, h: SizeManager.s_05),
              ),
              Container(
                padding: const EdgeInsets.all(SizeManager.s10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(SizeManager.s22)),
                    border: Border.all(color: ColorManager.headOrange)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    collectionTextFormGrey(
                      title: 'Disease:',
                      textEditingController: disease,
                      validator: 'Enter the disease',
                      textInputType: TextInputType.text,
                      left: SizeManager.s10,
                      right: SizeManager.s10,
                      top: SizeManager.s10,
                      bottom: SizeManager.s10,
                    ),
                    collectionTextFormGrey(
                      title: 'Therapist:',
                      textEditingController: therapist,
                      validator: 'Enter the Therapist',
                      textInputType: TextInputType.text,
                      left: SizeManager.s10,
                      right: SizeManager.s10,
                      top: SizeManager.s10,
                      bottom: SizeManager.s10,
                    ),
                    collectionTextFormGrey(
                      title: 'Date:',
                      textEditingController: date,
                      validator: 'Enter the Date',
                      textInputType: TextInputType.datetime,
                      left: SizeManager.s10,
                      right: SizeManager.s10,
                      top: SizeManager.s10,
                      bottom: SizeManager.s10,
                    ),
                    collectionTextFormGrey(
                      title: 'Perscription:',
                      textEditingController: perscription,
                      validator: 'Enter the Perscription:',
                      textInputType: TextInputType.text,
                      left: SizeManager.s10,
                      right: SizeManager.s10,
                      top: SizeManager.s40,
                      bottom: SizeManager.s40,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: hightMedia(context: context, h: SizeManager.s_05),
              ),
              Align(
                  alignment: Alignment.center,
                  child: greenContainer(
                      fontSize: SizeManager.s14,
                      text: 'Add outsourse diagnosis',
                      function: () {},
                      bottom: SizeManager.s12,
                      left: SizeManager.s12,
                      right: SizeManager.s12,
                      top: SizeManager.s12)),
              const SizedBox(height: SizeManager.s14),
              Align(
                  alignment: Alignment.center,
                  child: greenContainer(
                      fontSize: SizeManager.s14,
                      text: 'Add test results',
                      function: () {},
                      bottom: SizeManager.s12,
                      left: SizeManager.s12,
                      right: SizeManager.s12,
                      top: SizeManager.s12)),
              const SizedBox(height: SizeManager.s14),
            ],
          ),
        ),
      ),
    );
  }
}
