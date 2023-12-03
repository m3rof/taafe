
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);
  bool like=false;
  bool comment=false;

  void makeLike(){
    like=!like;
    emit(PostsLikeState());
  }
  void makeCommsent(){
    comment=!comment;
    emit(PostsCommentState());
  }
  static final List<String> list = ['Depression', 'Anxiety Disorders'];
  var category;

  void showResult(value, String selectedItem) {
    selectedItem = value as String;
    emit(PostsDropState());
  }

  static final List<String> type = ['Your name ', 'Anonymous member'];
  String currentType=type[0];

  void radioFunction(value){
    currentType=value;
    emit(PostsTypeState());
  }

  void checkValidation({required context,
    required GlobalKey<FormState> key,
    required TextEditingController title,
    required TextEditingController desvription,
    required TextEditingController tags
  }) {
    if (key.currentState!.validate()) {
      emit(PostsValidationState());

    }

}
}
