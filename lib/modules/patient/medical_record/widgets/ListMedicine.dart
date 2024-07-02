
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/resourses/color_manager.dart';
import '../../../../shared/resourses/styles.dart';
import '../../../../shared/resourses/value_app.dart';
import '../medical_record_cubit/medical_record_cubit.dart';

class ListMedicine extends StatelessWidget {
  const ListMedicine({
    super.key,
    required this.cubit,
  });

  final MedicalRecordCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: cubit.medicine.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
                dismissible: DismissiblePane(
                  onDismissed: () {
                    cubit.deleteMedicine(
                        cubit.medicine[index]['id'],
                        '${userData!.specialty}',
                        index);
                  },
                ),
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      cubit.deleteMedicine(
                          cubit.medicine[index]['id'],
                          '${userData!.specialty}',
                          index);
                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ]),
            child: Container(
              padding: EdgeInsets.all(15),
              color: ColorManager.primaryColor,
              child: Text(
                'name: ${cubit.medicine[index]['name']} doctor name: ${cubit.medicine[index]['doctorName']} auther: ${cubit.medicine[index]['auther']}',
                style: StylesManager.itemHome.copyWith(
                    fontSize: SizeManager.s16,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
