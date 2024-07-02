import 'package:flutter/material.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/resourses/styles.dart';
import '../../../../shared/resourses/value_app.dart';



class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.content,
  });

  final String image, title, content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: hightMedia(context: context, h: SizeManager.s_2),
        ),
        AspectRatio(
          aspectRatio: 2 / 1.5,
          child: Image.asset(
            image,
          ),
        ),
        SizedBox(
          height: SizeManager.s16,
        ),
        Text(
          title,
          style: StylesManager.itemHome.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: SizeManager.s16,
        ),
        Text(
          content,
          style: StylesManager.or,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
