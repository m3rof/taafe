import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  List searchResult = [];

  void getSearchResult(String search) {
    emit(SearchInitialState());
    DioHelper.getData(
        url: searchPost,
        query: {'loadBlock': 1, 'searchText': search}).then((value) {
      print(value.data);

      if (search.isNotEmpty) {
        searchResult = value.data;
      } else {
        searchResult = [];
      }
      emit(SearchSuccessState());
    }).catchError((Error) {
      print(Error);
      emit(SearchErrorState());
    });
  }


}
