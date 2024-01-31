import 'package:flutter/material.dart';

import '../../../shared/resourses/color_manager.dart';
import '../../../shared/resourses/value_app.dart';

class OnboardingSkip extends StatelessWidget {

  OnboardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: SizeManager.s20,
        right: SizeManager.s2,
        child: TextButton(
            onPressed: (){},
            child: Text(
              'skip',
              style: TextStyle(
                  fontSize: SizeManager.s18,
                  color: ColorManager.primaryColor),
            )));
  }
}
