import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/resourses/color_manager.dart';
import '../../../shared/resourses/value_app.dart';

class DividerMedicalRecord extends StatelessWidget {
  const DividerMedicalRecord({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: SizeManager.s10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dividerBlue(
                width: widthMedia(context: context, x: SizeManager.s_4),
                color: ColorManager.greenColor),
            const SizedBox(
              height: SizeManager.s20,
            ),
          ],
        ),
      ],
    );
  }
}
