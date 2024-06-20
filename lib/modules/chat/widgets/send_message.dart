
import 'package:flutter/material.dart';

import '../../../shared/resourses/color_manager.dart';

class SendMessage extends StatelessWidget {
  String message;

  SendMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 15,
              ),
              SizedBox(width: 15),
              CircleAvatar(
                  radius: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Image.network(
                        'https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=1541'),
                  ))            ],
          ),
          SizedBox(
            height: 4,
          ),
          Container(
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  color: ColorManager.greenColor),
              child: Text(
                message,
                style: TextStyle(color: Colors.white,fontSize: 22),
              )),
        ],
      ),
    );
  }
}
