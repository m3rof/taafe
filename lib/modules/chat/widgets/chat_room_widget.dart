
import 'package:flutter/material.dart';

import '../../../shared/resourses/assets_manager.dart';

class ChatRoomsWidget extends StatelessWidget {
  const ChatRoomsWidget({
    super.key,
    required this.nameSender,
    required this.lastMessage,
    required this.function
  });

  final String nameSender;
  final String lastMessage;
final function;

@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:function,
      child:
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              decoration: true
                  ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                border: Border.all(
                  width: 2,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
                // shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              )
                  : BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(AssetsManager.me),
              ),
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.65,
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            nameSender,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          true
                              ? Container(
                            margin: const EdgeInsets.only(left: 5),
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                            ),
                          )
                              : Container(
                            child: null,
                          ),
                        ],
                      ),
                      Text(
                        '4:00',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      lastMessage,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
