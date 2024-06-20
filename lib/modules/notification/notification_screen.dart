import 'package:awesome_icons/awesome_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/models/notification_model/notification_model.dart';
import 'package:taafe/modules/notification/notification_manager/notification_cubit.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';

import 'notification_manager/notification_state.dart';
import 'widgets/notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Notification',
              style: TextStyle(color: Colors.white, fontSize: 25)),
          backgroundColor: ColorManager.primaryColor),
      body: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NotificationCubit.get(context);
          return StreamBuilder<QuerySnapshot<NotificationModel>>(
            stream: cubit.getNotification(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              var notification = snapshot.data?.docs.reversed
                  .map((docs) => docs.data())
                  .toList();
              return notification!.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      reverse: true,
                      itemBuilder: (context, index) {
                        return NotificationTiles(
                            title: notification!.elementAt(index).header,
                            subtitle: notification!.elementAt(index).text,
                            onTap: () {},
                            seen: notification!.elementAt(index).seen,
                            date: '10/10/2002');
                      },
                      itemCount: notification?.length ?? 0,
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/notification.png'),
                            width: 150,
                            height: 150,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'there is nothing here',
                            style:
                                StylesManager.itemHome.copyWith(fontSize: 25),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'we will use this space to alert you',
                            style: StylesManager.label
                                .copyWith(fontSize: 18, color: Colors.grey),
                          )
                        ],
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}

Widget listNotification(String title, bool subtitle) {
  return ListTile(
    title: Text(title),
    subtitle: Text(subtitle.toString()),
  );
}
