import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/drawer_items/appointment/appointment_cubit/appointment_cubit.dart';
import 'package:taafe/modules/drawer_items/appointment/appointment_cubit/appointment_state.dart';
import 'package:taafe/shared/components/constants.dart';

import '../../../shared/components/components.dart';
import '../../../shared/resourses/value_app.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=AppointmentCubit.get(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AppointmentCubit,AppointmentState>(
        listener: (context, state) {},
        builder: (context, state) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: SizeManager.s24, right: SizeManager.s22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'appointment',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: hightMedia(context: context, h: SizeManager.s_07),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            cubit.changeToTrue();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: SizeManager.s50, vertical: SizeManager.s10),
                            decoration:  BoxDecoration(
                                color:cubit.history?cubit.colorSelected[0]:cubit.colorUnSelected[0],
                                borderRadius:
                                const BorderRadius.all(Radius.circular(SizeManager.s18))),
                            child:  Text(
                              'History',
                              style: TextStyle(
                                  color: cubit.history?cubit.colorSelected[1]:cubit.colorUnSelected[1],
                                  fontSize: SizeManager.s18),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            cubit.changeToFalse();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: SizeManager.s40, vertical: SizeManager.s10),
                            decoration:  BoxDecoration(
                                color:cubit.history==false?cubit.colorSelected[0]:cubit.colorUnSelected[0],
                                borderRadius:
                                const BorderRadius.all(Radius.circular(SizeManager.s18))),
                            child: Text(
                              'Up coming',
                              style: TextStyle(
                                  color:cubit.history==false?cubit.colorSelected[1]:cubit.colorUnSelected[1],
                                  fontSize: SizeManager.s18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SizeManager.s20,),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: SizeManager.s10, right: SizeManager.s10),
                child: listViewAppointmentV(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
