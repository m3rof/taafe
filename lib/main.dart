import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/about_doctor/about_doctor_screen.dart';
import 'package:taafe/modules/drawer_items/appointment/appointment_cubit/appointment_cubit.dart';
import 'package:taafe/modules/login/login_cubit/login_cubit.dart';
import 'package:taafe/modules/register/register_screen.dart';
import 'package:taafe/shared/network/remote/dio_helper.dart';

import 'layout/home/home_cubit/home_cubit.dart';
import 'layout/home/home_screen.dart';
import 'modules/login/login_screen.dart';
import 'modules/register/register_cubit/register_cubit.dart';
import 'shared/bloc_observer/bloc_observer.dart';
import 'shared/resourses/themes.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'taafe',
        theme: ThemeManager.themeApp,
        home:const AboutDoctorScreen()
      ),
    );
  }
}
