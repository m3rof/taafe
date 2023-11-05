import 'package:flutter/material.dart';
import 'package:taafe/shared/components/components.dart';

import '../../../shared/resourses/value_app.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  late TextEditingController height;
  late TextEditingController weigth;


  @override
  void initState() {
    height = TextEditingController();
    weigth=TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    height.dispose();
    weigth.dispose();
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
              const Text('My Account'),
              const SizedBox(
                height: SizeManager.s20,
              ),

              collectionTextFormGrey(
                  title: 'Height (cm):',
                  textEditingController: height,
                  validator: 'Enter your height',
                  textInputType: TextInputType.number,
                  left: SizeManager.s10,
                  right: SizeManager.s10,
                  top: SizeManager.s10,
                  bottom: SizeManager.s10),

              collectionTextFormGrey(
                  title: 'Weight (kg):',
                  textEditingController: weigth,
                  validator: 'Enter your weight',
                  textInputType: TextInputType.number,
                  left: SizeManager.s10,
                  right: SizeManager.s10,
                  top: SizeManager.s10,
                  bottom: SizeManager.s10),


            ],
          ),
        ),
      ),
    );
  }
}
