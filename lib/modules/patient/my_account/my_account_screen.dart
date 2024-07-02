import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/shared/components/components.dart';
import '../../../shared/resourses/value_app.dart';
import 'my_account_cubit/my_account_cubit.dart';
import 'my_account_cubit/my_account_state.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  late TextEditingController height;
  late TextEditingController weigth;
  late GlobalKey<FormState> key;

  @override
  void initState() {
    height = TextEditingController();
    weigth = TextEditingController();
    key = GlobalKey();
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
    var cubit = MyAccountCubit.get(context);
    return BlocConsumer<MyAccountCubit, MyAccountState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: key,
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
                  collectionDropFormField(
                      text: 'Blood type:',
                      validator: 'Enter your Blood type',
                      selectedItem: cubit.selectedItemBload,
                      list: MyAccountCubit.bload,
                      function: (value) {
                        cubit.showResultBload(value);
                      },
                      left: SizeManager.s10,
                      right: SizeManager.s10,
                      top: SizeManager.s10,
                      bottom: SizeManager.s10),
                  collectionDropFormField(
                      text: 'Martial status:',
                      validator: 'Enter your Martial status',
                      selectedItem: cubit.selectedItemMartial,
                      list: MyAccountCubit.martialStatus,
                      function: (value) {
                        cubit.showResultMartial(value);
                      },
                      left: SizeManager.s10,
                      right: SizeManager.s10,
                      top: SizeManager.s10,
                      bottom: SizeManager.s10),
                  collectionDropFormField(
                      text: 'Alcohol:',
                      validator: 'Enter your Alcohol',
                      selectedItem: cubit.selectedItemAlcohol,
                      list: MyAccountCubit.alcohol,
                      function: (value) {
                        cubit.showResultAlcohol(value);
                      },
                      left: SizeManager.s10,
                      right: SizeManager.s10,
                      top: SizeManager.s10,
                      bottom: SizeManager.s10),
                  collectionDropFormField(
                      text: 'Drugs:',
                      validator: 'Enter your Drugs',
                      selectedItem: cubit.selectedItemDrugs,
                      list: MyAccountCubit.drugs,
                      function: (value) {
                        cubit.showResultDrugs(value);
                      },
                      left: SizeManager.s10,
                      right: SizeManager.s10,
                      top: SizeManager.s10,
                      bottom: SizeManager.s10),
                  collectionDropFormField(
                      text: 'Are you religious ?:',
                      validator: 'choice option',
                      selectedItem: cubit.selectedItemReligious,
                      list: MyAccountCubit.religious,
                      function: (value) {
                        cubit.showResultReligious(value);
                      },
                      left: SizeManager.s10,
                      right: SizeManager.s10,
                      top: SizeManager.s10,
                      bottom: SizeManager.s10),
                  collectionDropFormField(
                      text: 'Religion:',
                      validator: 'Enter your Religion',
                      selectedItem: cubit.selectedItemReligion,
                      list: MyAccountCubit.religion,
                      function: (value) {
                        cubit.showResultReligion(value);
                      },
                      left: SizeManager.s10,
                      right: SizeManager.s10,
                      top: SizeManager.s10,
                      bottom: SizeManager.s10),
                  const SizedBox(
                    height: SizeManager.s16,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: greenContainer(
                          text: 'Save information',
                          function: () {
                            cubit.checkValidation(
                                context: context,
                                key: key,
                                heightController: height,
                                weightController: weigth);
                          },
                          fontSize: SizeManager.s16,
                          bottom: SizeManager.s8,
                          top: SizeManager.s8,
                          right: SizeManager.s16,
                          left: SizeManager.s16)),
                  const SizedBox(
                    height: SizeManager.s16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
