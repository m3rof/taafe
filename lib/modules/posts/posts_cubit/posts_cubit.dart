
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

}
