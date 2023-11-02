import 'package:awesome_icons/awesome_icons.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import '../../../modules/navigation_bar_items/blogs/blogs_screen.dart';
import '../../../modules/navigation_bar_items/communities/communities_screen.dart';
import '../../../modules/navigation_bar_items/q_a/q_a_screen.dart';
import '../../../modules/navigation_bar_items/test/test_screen.dart';
import '../../../modules/navigation_bar_items/therapists/therapists_screen.dart';
import '../home_widget/home_body.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<ItemServices> listServices = [
    ItemServices(AssetsManager.therapists, StringManager.therapists),
    ItemServices(AssetsManager.medical, StringManager.medical),
    ItemServices(AssetsManager.blogs, StringManager.blogs),
    ItemServices(AssetsManager.community, StringManager.community),
    ItemServices(AssetsManager.qA, StringManager.qA),
    ItemServices(AssetsManager.tests, StringManager.tests),
  ];

  List<ItemTest> listTest = [
    ItemTest(AssetsManager.worry, (){}),
    ItemTest(AssetsManager.anxiety, (){}),
    ItemTest(AssetsManager.deperession, (){}),
    ItemTest(AssetsManager.adiction, (){}),
    ItemTest(AssetsManager.parent, (){}),
    ItemTest(AssetsManager.arizona, (){}),

  ];
  
  List<Widget>listPage=[
    const HomeBody(),
    const TherapistsScreen(),
    const BlogsScreen(),
    const CommunitiesScreen(),
    const QAScreen(),
    const TestScreen()
  ];

  List<Widget>listIcons=[
    const Icon(Icons.home),
    const Icon(FontAwesomeIcons.user),
    const Icon(Icons.message_outlined),
    const Icon(FontAwesomeIcons.users),
    const Icon(FontAwesomeIcons.comments),
    const Icon(FontAwesomeIcons.solidFile),

  ];

  int numPage=0;

  void changePage (int index){
    numPage=index;
    emit(ChangePagesState());
  }
}

class ItemServices {
  String assetsService;
  String nameServices;

  ItemServices(this.assetsService, this.nameServices);
}

class ItemTest {
  String assetsService;
  Function function;

  ItemTest(this.assetsService, this.function);
}
