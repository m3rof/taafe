import 'package:flutter/material.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/resourses/value_app.dart';

class DiagnosisScreen extends StatelessWidget {
  const DiagnosisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: SizeManager.s24, right: SizeManager.s22),
        child: Column(
          children: [
            Text(
              'diagnosis',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: SizeManager.s28),
            ),
            SizedBox(height: hightMedia(context: context, h: SizeManager.s_05),),
            Container(

            )
          ],
        ),
      ),
    );
  }
}
