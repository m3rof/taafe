import 'dart:ffi';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/models/notification_model/notification_model.dart';
import 'package:taafe/modules/login/login_cubit/login_state.dart';
import 'package:taafe/modules/notification/notification_manager/notification_state.dart';
import 'package:taafe/modules/register/register_screen.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/network/remote/dio_helper.dart';
import 'package:taafe/shared/network/remote/end_points.dart';

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
