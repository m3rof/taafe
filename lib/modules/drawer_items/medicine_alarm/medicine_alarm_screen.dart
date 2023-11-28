import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/drawer_items/medicine_alarm/medicine_alarm_cubit/medicine_alarm_cubit.dart';
import 'package:taafe/modules/drawer_items/medicine_alarm/medicine_alarm_cubit/medicine_alarm_state.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/resourses/value_app.dart';

class MedicineAlarmScreen extends StatelessWidget {
  const MedicineAlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = MedicineAlarmCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<MedicineAlarmCubit, MedicineAlarmState>(
          listener: (context, state) => () {},
          builder: (context, state) => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: SizeManager.s200,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(SizeManager.s30),
                              bottomRight: Radius.circular(SizeManager.s30))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppBar(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: SizeManager.s22),
                            child: Text(
                              'Medicine alarm',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: SizeManager.s22),
                            child: collectionDropFormField(
                                text: '',
                                validator: '',
                                selectedItem: cubit.selectedItemAlarm,
                                list: MedicineAlarmCubit.alarm,
                                function: (value) =>
                                    cubit.showResult(value, cubit.selectedItemAlarm),
                                left: SizeManager.s8,
                                right: SizeManager.s8,
                                top: SizeManager.s16,
                                bottom: SizeManager.s16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: SizeManager.s20),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(SizeManager.s10),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(SizeManager.s30),
                          topRight: Radius.circular(SizeManager.s30))),
                  child:listAlarm(cubit),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
