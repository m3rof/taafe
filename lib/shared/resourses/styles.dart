import 'package:flutter/material.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/family_manager.dart';
import 'package:taafe/shared/resourses/value_app.dart';

class StylesManager {
  static TextStyle welcome = const TextStyle(
      fontSize: SizeManager.s24,
      fontFamily: FamilyManager.myriad,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
      color: ColorManager.headBlack);
  static TextStyle label = const TextStyle(
      color: ColorManager.primaryColor, fontSize: SizeManager.s16,fontFamily: FamilyManager.myriad,);
  static TextStyle hint = const TextStyle(color: ColorManager.headBlack,fontFamily: FamilyManager.myriad,);
  static TextStyle or =
      const TextStyle(color: Colors.grey, fontSize: SizeManager.s14);
  static TextStyle loginCreate = const TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: SizeManager.s20);
  static TextStyle errorField = const TextStyle(
      color: ColorManager.headOrange, fontSize: SizeManager.s12);

  static TextStyle registerCreate = const TextStyle(
      color: ColorManager.textWhite,
      fontSize: SizeManager.s30,
      fontFamily: FamilyManager.myriad);
  static TextStyle hi = const TextStyle(
    color: ColorManager.primaryColor,
    fontSize: SizeManager.s14,
  );
  static TextStyle bodySmall = const TextStyle(
    color: ColorManager.headOrange,
    fontSize: SizeManager.s18,
  );
  static TextStyle bodyMedium = const TextStyle(
    color: ColorManager.headOrange,
    fontSize: SizeManager.s24,
    fontWeight: FontWeight.w500,
  );
  static TextStyle bodyLarge = const TextStyle(
    color: ColorManager.headOrange,
    fontWeight: FontWeight.w600,
    fontSize: SizeManager.s30,
  );
  static TextStyle headPrimary1 = const TextStyle(
    color: ColorManager.primaryColor,
    fontWeight: FontWeight.w400,
    fontSize: SizeManager.s30,
  );
  static TextStyle headPrimary2 = const TextStyle(
    color: ColorManager.primaryColor,
    fontWeight: FontWeight.w600,
    fontSize: SizeManager.s30,
  );
  static TextStyle headPrimary3 = const TextStyle(
    color: ColorManager.primaryColor,
    fontWeight: FontWeight.w600,
    fontSize: SizeManager.s20,
    fontFamily: FamilyManager.myriad,
  );
  static TextStyle itemHome = const TextStyle(
    color: ColorManager.headBlack,
    fontWeight: FontWeight.w500,
    fontSize: SizeManager.s18,
  );
  static TextStyle category = const TextStyle(
    color: ColorManager.primaryColor,
    fontSize: SizeManager.s12,
  );

  static TextStyle greenContainer = const TextStyle(
    color: ColorManager.textWhite,
    fontSize: SizeManager.s10,
  );
  static TextStyle drContent = const TextStyle(
    color: ColorManager.primaryColor,
    fontSize: SizeManager.s16,
  );
}
