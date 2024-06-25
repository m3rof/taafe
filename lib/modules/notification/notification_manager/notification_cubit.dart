
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taafe/models/notification_model/notification_model.dart';

import 'package:taafe/modules/notification/notification_manager/notification_state.dart';


class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitialState());

  static NotificationCubit get(context) => BlocProvider.of(context);

   CollectionReference<NotificationModel> getNotificationCollection() {
    return FirebaseFirestore.instance.collection('notifications').withConverter(
      fromFirestore: (snapshot, _) => NotificationModel.fromjson(snapshot.data()!),
      toFirestore: (Message, options) => Message.tojson(),
    );
  }

   Stream<QuerySnapshot<NotificationModel>> getNotification() {
    return getNotificationCollection().snapshots();
  }
}
