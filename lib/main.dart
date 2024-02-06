import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/about_doctor/about_doctor_screen.dart';
import 'package:taafe/modules/drawer_items/appointment/appointment_cubit/appointment_cubit.dart';
import 'package:taafe/modules/login/login_cubit/login_cubit.dart';
import 'package:taafe/modules/login/login_screen.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';
import 'package:taafe/modules/posts/posts_cubit/posts_cubit.dart';
import 'package:taafe/modules/register/register_screen.dart';
import 'package:taafe/modules/search/search_cubit/search_cubit.dart';
import 'package:taafe/modules/setting_items/my_account/my_account_cubit/my_account_cubit.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/network/local/notification/notification.dart';
import 'package:taafe/shared/network/remote/dio_helper.dart';
import 'layout/home/home_cubit/home_cubit.dart';
import 'layout/home/home_screen.dart';
import 'modules/drawer_items/medicine_alarm/medicine_alarm_cubit/medicine_alarm_cubit.dart';
import 'modules/navigation_bar_items/communities/communites_cubit/community_cubit.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/register/register_cubit/register_cubit.dart';
import 'modules/test.dart';
import 'shared/bloc_observer/bloc_observer.dart';
import 'shared/network/remote/end_points.dart';
import 'shared/resourses/themes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => LoginCubit()),
        BlocProvider(create:(context) => RegisterCubit()),
        BlocProvider(create:(context) => HomeCubit()),
        BlocProvider(create: (context) => AppointmentCubit()),
        BlocProvider(create: (context) => MyAccountCubit()),
        BlocProvider(create: (context) => MedicineAlarmCubit()),
        BlocProvider(create: (context) => PostsCubit()),
        BlocProvider(create: (context) => CommunityCubit()..getList()),
        BlocProvider(create: (context) => BlogCubit()..getList()),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'taafe',
        theme: ThemeManager.themeApp,
        home: MyHomePage(),
      ),
    );
  }
}
