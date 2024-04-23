import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';
import '../../../shared/resourses/color_manager.dart';
import '../../../shared/resourses/styles.dart';
import '../../../shared/resourses/value_app.dart';

Widget dateEdit(TextEditingController date,String label ,function) {
  return dateField(
      date,
      StylesManager.itemHome.copyWith(fontSize: 20),
       InputDecoration(
        prefixIcon: Icon(FontAwesomeIcons.calendar, color: Colors.grey),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black87, fontSize: 18),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide(width: SizeManager.s1, color: Colors.grey)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide(width: SizeManager.s1, color: Colors.grey)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide(color: ColorManager.primaryColor)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide(color: ColorManager.headOrange)),
      ),
      function);
}
