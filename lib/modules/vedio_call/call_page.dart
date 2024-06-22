import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

final userId = Random().nextInt(9999);

class CallPage extends StatelessWidget {
  final String callId;
  const CallPage({
    required this.callId,
    super.key});

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: CallInfo.appID,
      appSign: CallInfo.appSign,
      callID: callId,
      userID: userId.toString(),
      userName: "UserName: $userId",
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
