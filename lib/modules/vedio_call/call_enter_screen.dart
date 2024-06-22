import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:taafe/modules/vedio_call/call_page.dart';
import 'package:taafe/shared/components/constants.dart';

import '../../shared/components/components.dart';
import '../../shared/resourses/color_manager.dart';
import '../../shared/resourses/strings_manager.dart';

class CallEnterScreen extends StatelessWidget {
  const CallEnterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController callIdController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 150,
              width: 150,
            ),
            Text(
              "Please Enter The Call ID",
              style: TextStyle(color: ColorManager.primaryColor),
            ),
            textFieldRegister(
              textInputType: TextInputType.emailAddress,
              email: false,
              controller: callIdController,
              hint: "Call ID",
              validator: StringManager.emailValidatorRegister,
            ),
            ElevatedButton(
                onPressed: () {
                  animatedNavigateTo(
                    context: context,
                    widget: CallPage(callId: callIdController.text),
                    direction: PageTransitionType.fade,
                    curve: Curves.bounceInOut,
                  );
                },
                child: const Text('Join Call',
                    style: TextStyle(color: ColorManager.textWhite))),
          ],
        ),
      ),
    );
  }
}
