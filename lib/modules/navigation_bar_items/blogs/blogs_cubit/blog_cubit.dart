import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/navigation_bar_items/communities/communites_cubit/community_state.dart';
import 'package:taafe/shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_points.dart';
import 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(BlogInitialState());

  static BlogCubit get(context) => BlocProvider.of(context);

  List blog = [];

  void getList() {
    DioHelper.getData(url: blogList,query: {'loadBlock': 1}).then((value) {
      print(value.data);
      blog = value.data;
      emit(BlogSuccessState());
    }).catchError((Error) {
      print(Error);
      emit(BlogErrorState());
    });
  }
}
