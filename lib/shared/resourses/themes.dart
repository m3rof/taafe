import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';

import 'value_app.dart';

class ThemeManager {
  static ThemeData themeApp = ThemeData(
      textTheme: TextTheme(
        bodyLarge: StylesManager.bodyLarge,
        bodyMedium:  StylesManager.bodyMedium,
        bodySmall:  StylesManager.bodySmall

      ),

      scaffoldBackgroundColor: ColorManager.backgroundColor,

      primaryColor: ColorManager.primaryColor,

      iconTheme:const IconThemeData(color: ColorManager.primaryColor),

      appBarTheme: const AppBarTheme(
          backgroundColor: ColorManager.transparentColor,
          elevation: 0,
          iconTheme: IconThemeData(color: ColorManager.primaryColor),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.primaryColor,
              statusBarBrightness: Brightness.light)),

      inputDecorationTheme: InputDecorationTheme(
        errorStyle: StylesManager.errorField,
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeManager.s30)),
            borderSide: BorderSide(color: ColorManager.primaryColor)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeManager.s30)),
            borderSide: BorderSide(color: ColorManager.headOrange)),
        prefixIconColor: ColorManager.primaryColor,
        labelStyle: StylesManager.label,
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeManager.s30)),
            borderSide: BorderSide(color: ColorManager.primaryColor)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeManager.s30)),
            borderSide: BorderSide(color: ColorManager.primaryColor)),
        border: const OutlineInputBorder(),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(SizeManager.s35)), // <-- Radius
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: SizeManager.s55, vertical: SizeManager.s14),
          primary: ColorManager.primaryColor,
        ),
      ));

}
