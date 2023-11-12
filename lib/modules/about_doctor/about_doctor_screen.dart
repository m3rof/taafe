import 'package:flutter/material.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';
import 'package:taafe/shared/resourses/value_app.dart';

import '../../shared/components/components.dart';

class AboutDoctorScreen extends StatelessWidget {
  const AboutDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(backgroundColor: ColorManager.primaryColor,
        appBar: AppBar(),
        body: aboutDoctor(context),
        ),
        const SizedBox(height: SizeManager.s200,child: Image(image: AssetImage(AssetsManager.bubble))),
        Positioned(
          top: hightMedia(context: context, h: SizeManager.s_1),
          child: CircleAvatar(
            radius: hightMedia(context: context, h: SizeManager.s_1),
            backgroundColor: Colors.grey.shade700,
            backgroundImage:AssetImage(AssetsManager.me),
          ),
        )
        // Container(
        //   height: ,
        // )
      ],
    );
  }
}
