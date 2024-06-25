import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:taafe/modules/onboarding/onboarding_cubit/onboarding_cubit.dart';
import 'package:taafe/modules/onboarding/onboarding_cubit/onboarding_state.dart';
import 'package:taafe/shared/resourses/color_manager.dart';


import '../../../shared/components/constants.dart';
import '../../../shared/resourses/styles.dart';
import '../../../shared/resourses/value_app.dart';

class HobbyScreen extends StatelessWidget {
OnBoardingCubit cubit;

HobbyScreen(this.cubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit,OnBoardingState>(
      listener: (context, state) {},
      builder: (context, state) =>  Column(
        children: [
          SizedBox(
            height: hightMedia(context: context, h: SizeManager.s_2),
          ),
          Text(
            'Your Interests',
            style: StylesManager.itemHome.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          Text(
            'Select a few genres to help us to track your habit',
            style: StylesManager.or,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: SizeManager.s22,
          ),
          GroupButton(
            onSelected: (value, index, isSelected) {
              cubit.hobbyList(value, isSelected);
            },
            isRadio: false,
              maxSelected: 3,
              buttons:const [
                'Eat Healthy',
                'music',
                'reading',
                'walking',
                'Gym',
                'IT',
                'Learning',
                'Rap',
                'Swiming',
                'movies',
                'Vlogs',
                'football',
                'jogging',
                'Alternative'
              ],
              options:const GroupButtonOptions(buttonHeight: 50,buttonWidth: 100,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  selectedColor: ColorManager.primaryColor)),
        ],
      ),
    );
  }
}
