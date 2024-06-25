import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:page_transition/page_transition.dart';


import '../../../shared/components/components.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';
import '../add_post_screen.dart';
import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);
  bool like = false;
  bool comment = false;

  void makeAndDeleteLike(int postID,int patientID,bool likedByUser) {
    emit(PostsInitialState());
    if(likedByUser==false){
      DioHelper.postData(url: reactionSend, data: {
        'postID':postID,
        'patientID':patientID
      }).then((value) {
        print(value.data);
         getPostsList(1);
        emit(PostsLikeSuccessState());
      }).catchError((Error) {
        print(Error.toString());
        emit(PostsLikeErrorState());
      });
    }
    else{
      DioHelper.deleteData(url: reactionSend, data: {
        'postID':postID,
        'patientID':patientID
      }).then((value) {
        getPostsList(1);
        print(value.data);
        emit(PostsLikeDeleteSuccessState());
      }).catchError((Error) {
        print(Error);
        emit(PostsLikeDeleteErrorState());
      });
    }
  }


  void getComment(int postID,int loadBlock) {
      DioHelper.postData(url: commentGet, data: {
        'postID':postID,
        'loadBlock':loadBlock
      }).then((value) {
        print(value.data);
        emit(PostsCommentSuccessState());
      }).catchError((Error) {
        print(Error);
        emit(PostsCommentErrorState());
      });
  }

  var category;
  var idCommunity;

  void showResult(value, selectedItem, List community) {
    selectedItem = value;
    for (var e in community) {
      if (selectedItem == e['name']) {
        idCommunity = e['id'];
        print(idCommunity);
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

  void checkValidation({required context,
    required GlobalKey<FormState> key,
    required TextEditingController title,
    required TextEditingController desvription,
    required TextEditingController tags,
    required int which,
    required int idPost
  }) {
    if (key.currentState!.validate()) {
      whichFunction(idPost, 1, idCommunity, title.text, currentType, which);
      emit(PostsValidationState());
    }
  }

  List post = [];

  void getPostsList(int id) {
    emit(PostsInitialState());
    DioHelper.getData(url: postFeed, query: {'loadBlock': 1, 'communityID': id,'patientID': 1})
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

  List<PopupMenuEntry> menuePop(context, int idPost, int index) {
    return [
      PopupMenuItem(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(PageTransition(
                  duration: const Duration(milliseconds: 600),
                  type: PageTransitionType.rightToLeft,
                  child: AddPostScreen(2, idPost)));
            },
            leading: Icon(FontAwesomeIcons.edit),
            title: Text('edit post'),
          )),
      PopupMenuItem(
          child: ListTile(
            onTap: () {
              askDialogAwsome(context, 'Are you sure', DialogType.question, () {
                deletePost(idPost, 1);
                patientPost.removeAt(index);
                emit(PostsRemoveItemState());
              });
            },
            leading: Icon(FontAwesomeIcons.trash),
            title: Text('delete post'),
          ))
    ];
  }


  void addPost(int patientID, int communityID, String mainText,
      String hideIdentity) {
    var now = DateTime.now();
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

  void editPost(int postID,
      int patientID, int communityID, String mainText, String hideIdentity) {
    var now = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    String formattedDate = formatter.format(now);
    DioHelper.postData(url: editPosts, data: {
      'patientID': patientID,
      'communityID': communityID,
      'mainText': mainText,
      'editDate': formattedDate,
      'postID': postID,
      'hideIdentity': hideIdentity == 'Your name' ? false : true,
    }).then((value) {
      print(value.data);
    }).catchError((Error) {
      print(Error);
    });
  }

  void whichFunction(int postID, int patientID, int communityID,
      String mainText, String hideIdentity, int which) {
    if (which == 1) {
      addPost(patientID, communityID, mainText, hideIdentity);
    }
    else {
      editPost(postID, patientID, communityID, mainText, hideIdentity);
    }
  }

  void deletePost(int postID, int patientID) {
    DioHelper.deleteData(url: deletePosts, data: {
      'postID': postID,
      'patientID': patientID
    }).then((value) {
      print(value.data);
    }).catchError((Error) {
      print(Error);
    });
  }


}
