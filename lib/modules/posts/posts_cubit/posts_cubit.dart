import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';
import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);
  bool like = false;
  bool comment = false;

  void makeLike() {
    like = !like;
    emit(PostsLikeState());
  }

  void makeCommsent() {
    comment = !comment;
    emit(PostsCommentState());
  }

  var category;
  var idCommunity;

  void showResult(value, selectedItem, List community) {
    selectedItem = value;
    for (var e in community) {
      if (selectedItem == e['name']) {
        idCommunity = e['id'];
      }
    }
    emit(PostsDropState());
  }

  static final List<String> type = ['Your name', 'Anonymous member'];
  String currentType = type[0];

  void radioFunction(value) {
    currentType = value;
    emit(PostsTypeState());
  }

  void checkValidation(
      {required context,
      required GlobalKey<FormState> key,
      required TextEditingController title,
      required TextEditingController desvription,
      required TextEditingController tags,
      }) {
    if (key.currentState!.validate()) {
      addPost(1,idCommunity, title.text,currentType);
      emit(PostsValidationState());
    }
  }

  List post = [];

  void getPostsList(int id) {
    emit(PostsInitialState());
    DioHelper.getData(url: postFeed, query: {'loadBlock': 1, 'communityID': id})
        .then((value) {
      post = value.data;
      emit(PostsSuccessState());
    }).catchError((Error) {
      print(Error);
      emit(PostsErrorState());
    });
  }

  List patientPost = [];

  void getPatientPosts() {
    emit(PostsInitialState());
    DioHelper.getData(url: postPatient, query: {'loadBlock': 1, 'patientID': 1})
        .then((value) {
      print(value.data);
      patientPost = value.data;
      emit(PostsSuccessState());
    }).catchError((Error) {
      print(Error);
      emit(PostsErrorState());
    });
  }

  final List<PopupMenuEntry> menueItems = [
    PopupMenuItem(
        child: ListTile(
      onTap: () {},
      leading: Icon(FontAwesomeIcons.edit),
      title: Text('edit post'),
    )),
    PopupMenuItem(
        child: ListTile(
      onTap: () {},
      leading: Icon(FontAwesomeIcons.trash),
      title: Text('delete post'),
    ))
  ];

  void addPost(
      int patientID, int communityID, String mainText, String hideIdentity) {
    var now =  DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    String formattedDate = formatter.format(now);
    DioHelper.postData(url: newPost, data: {
      'patientID': patientID,
      'communityID': communityID,
      'mainText': mainText,
      'date': formattedDate,
      'hideIdentity': hideIdentity == 'Your name' ? false : true,
    }).then((value) {
      print(value.data);
    }).catchError((Error) {
      print(Error);
    });
  }
}
