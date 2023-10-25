import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';

import '../../shared/resourses/value_app.dart';

class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: SizeManager.s24, right: SizeManager.s22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringManager.communities,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(
              height: SizeManager.s22,
            ),
            rowCommunity(
                itemCommunity(() {}, FontAwesomeIcons.angry,
                    'Anxiety Disorders'),
                itemCommunity(() {},FontAwesomeIcons.userMinus,
                    'Depression')),
            const SizedBox(
              height: SizeManager.s22,
            ),
            rowCommunity(
                itemCommunity(() {}, FontAwesomeIcons.headSideCough,
                    'Disorders'),
                itemCommunity(() {},FontAwesomeIcons.headSideVirus,
                    'Schizophrenia')),
            const SizedBox(
              height: SizeManager.s22,
            ),
            rowCommunity(
                itemCommunity(() {},FontAwesomeIcons.skull,
                    'Disruptive behaviour'),
                itemCommunity(() {},FontAwesomeIcons.batteryQuarter,
                    'Neurodevelopmental disorders')),
            const SizedBox(
              height: SizeManager.s22,
            ),
            rowCommunity(
                itemCommunity(() {},FontAwesomeIcons.eye,
                    'Porn Addiction'),
                itemCommunity(() {},FontAwesomeIcons.userInjured,
                    'Gender identity Disorder')),

          ],
        ),
      ),
    );
  }
}
