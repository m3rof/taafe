import 'package:flutter/material.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/shared/components/constants.dart';

import '../../../../shared/resourses/color_manager.dart';
import '../../../../shared/resourses/value_app.dart';



class OnboardingSkip extends StatelessWidget {

  OnboardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: SizeManager.s20,
        right: SizeManager.s2,
        child: TextButton(
            onPressed: (){
              moveScreen(context: context,screen: HomeScreen());
            },
            child: Text(
              'skip',
              style: TextStyle(
                  fontSize: SizeManager.s18,
                  color: ColorManager.primaryColor),
            )));
  }
}
