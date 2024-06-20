
import 'package:flutter/material.dart';

class ReciveMessage extends StatelessWidget {
  String message;

  ReciveMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Image.network(
                        'https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=1541'),
                  )),
              SizedBox(
                width: 15,
              ),
              SizedBox(width: 15),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Container(
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(30)),
                  color: Colors.grey[300]),
              child: Text(
                message,
                style: TextStyle(color: Colors.black,fontSize: 22),
              )),
        ],
      ),
    );
    ;
  }
}
