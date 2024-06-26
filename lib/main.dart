
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taafe/modules/drawer_items/appointment/appointment_cubit/appointment_cubit.dart';
import 'package:taafe/modules/drawer_items/diagnosis/diagnosis_cubit/diagnosis_cubit.dart';
import 'package:taafe/modules/login/login_cubit/login_cubit.dart';
import 'package:taafe/modules/login/login_screen.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';

import 'package:taafe/modules/notification/notification_manager/notification_cubit.dart';
import 'package:taafe/modules/posts/posts_cubit/posts_cubit.dart';

import 'package:taafe/modules/search/search_cubit/search_cubit.dart';
import 'package:taafe/shared/network/local/cache/cache_helper.dart';

import 'package:taafe/shared/network/remote/dio_helper.dart';
import 'layout/home/home_cubit/home_cubit.dart';

import 'layout/home/home_screen.dart';
import 'modules/chat/chat_cubit/chat_cubit.dart';

import 'modules/drawer_items/medicine_alarm/medicine_alarm_cubit/medicine_alarm_cubit.dart';
import 'modules/navigation_bar_items/communities/communites_cubit/community_cubit.dart';

import 'modules/patient/medical_record/medical_record_cubit/medical_record_cubit.dart';
import 'modules/patient/my_account/my_account_cubit/my_account_cubit.dart';
import 'modules/patient/onboarding/onboarding_cubit/onboarding_cubit.dart';
import 'modules/register/register_cubit/register_cubit.dart';

import 'shared/bloc_observer/bloc_observer.dart';

import 'shared/components/constants.dart';
import 'shared/resourses/themes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  token = CacheHelper.getData(key: "token");
  uId = CacheHelper.getData(key: "uId");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(
            create: (context) => HomeCubit()
              ..getPatientMain()
              ..getDoctorMain()..getUserDetails()),
        BlocProvider(create: (context) => AppointmentCubit()),
        BlocProvider(create: (context) => MyAccountCubit()),
        BlocProvider(create: (context) => MedicineAlarmCubit()),
        BlocProvider(create: (context) => PostsCubit()),
        BlocProvider(create: (context) => CommunityCubit()..getList()),
        BlocProvider(create: (context) => BlogCubit()..getListCategory()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => OnBoardingCubit()),
        BlocProvider(
            create: (context) => MedicalRecordCubit()
              ..getPatientInfo()
              ..getHobby()
              ..getDiagnose()
              ..getMedicine()),
        BlocProvider(create: (context) => DiagnosisCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'taafe',
        theme: ThemeManager.themeApp,

        home:token == null? const LoginScreen() : const HomeScreen(),

      ),
    );
  }
}
