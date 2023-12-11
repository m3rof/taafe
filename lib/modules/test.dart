import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/components/components.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () => showSheet(context, buildDatePicker(), () {
                  print(DateFormat('MM/dd/yyyy').format(dateTime));
                  Navigator.pop(context);
                }),
            child: Text('show')),
      ),
    );
  }



  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: dateTime,
          maximumYear: DateTime.now().year,
          onDateTimeChanged: (value) => setState(() {
            dateTime = value;
          }),
          mode: CupertinoDatePickerMode.date,
        ),
      );
}
