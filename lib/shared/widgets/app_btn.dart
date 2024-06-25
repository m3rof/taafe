import 'package:flutter/material.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';

class AppBtn extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Color? clr;
  final TextStyle? style;
  const AppBtn(
      {required this.label,
      required this.onPressed,
      this.clr,
      this.style,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
          textStyle: WidgetStateProperty.all(StylesManager.label),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(
              clr ?? ColorManager.primaryColor.withOpacity(0.6))),
      child: Text(
        label,
        style: style,
      ),
    );
  }
}
