
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/resourses/color_manager.dart';
import '../../../../shared/resourses/styles.dart';
import '../../../../shared/resourses/value_app.dart';


class TitleMedicalRecord extends StatelessWidget {
  IconData icon;
  String title;
  dynamic function;


  TitleMedicalRecord(this.icon, this.title,this.function);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: ColorManager.headOrange),
            const SizedBox(width: SizeManager.s14),
            Text(
              title,
              style: StylesManager.headPrimary3,
            ),
            Spacer(),
            IconButton(onPressed: function, icon: Icon(Icons.add))
          ],
        ),
        const SizedBox(height: SizeManager.s16),
      ],
    );
  }
}
