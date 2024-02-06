import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/navigation_bar_items/communities/communites_cubit/community_state.dart';
import 'package:taafe/shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_points.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(CommunityInitialState());

  static CommunityCubit get(context) => BlocProvider.of(context);

  List community = [];

  List name=[];

  void addName(){
    for(var e in community){
      name.add(e['name']);
    }
  }

  void getList() {
    DioHelper.getData(url: communityList).then((value) {
      print(value.data);
      community = value.data;
      addName();
      emit(CommunitySuccessState());
    }).catchError((Error) {
      print(Error);
      emit(CommunityErrorState());
    });
  }
}
