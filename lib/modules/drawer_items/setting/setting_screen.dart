import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:taafe/modules/setting_items/my_account/my_account_screen.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/resourses/strings_manager.dart';
import '../../../shared/resourses/value_app.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: SizeManager.s24, right: SizeManager.s22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: hightMedia(context: context, h: SizeManager.s_01),
                ),
                Text(StringManager.setting, style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge),
                SizedBox(
                  height: hightMedia(context: context, h: SizeManager.s_03),
                ),
                itemSetting(context, FontAwesomeIcons.user, 'Account', () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>const MyAccountScreen()));
                }),
                itemSetting(context, Icons.qr_code, 'QR Code', () {}),
                itemSetting(
                    context, FontAwesomeIcons.user, 'Following User', () {}),
                itemSetting(
                    context, FontAwesomeIcons.wallet, 'Payment Method', () {}),
                itemSetting(
                    context, FontAwesomeIcons.bell, 'Notifications', () {}),
                itemSetting(
                    context, FontAwesomeIcons.language, 'Language', () {}),
                itemSetting(context, Icons.shield, 'Privacy Policy', () {}),
                itemSetting(
                    context, Icons.call_split_outlined, 'Help Center', () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
