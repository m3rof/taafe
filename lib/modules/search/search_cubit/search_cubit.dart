
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
    DioHelper.getData(url: searchPost, query: {
      'loadBlock': 1,
      'searchText': search,
      'communityID': idCommunity,
      'patientID': 1
    }).then((value) {
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

  var selectedCategory;
  var idCommunity;

  void showResult(value, selectedItem, List community) {
    selectedItem = value;
    for (var e in community) {
      if (selectedItem == e['name']) {
        idCommunity = e['id'];
      }
    }
    emit(SearchDropState());
  }



}



