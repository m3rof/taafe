import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taafe/modules/medical_record/mediacal_record_screen.dart';
import 'package:taafe/shared/network/remote/end_points.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/value_app.dart';
import '../../shared/components/components.dart';
import '../../shared/resourses/assets_manager.dart';
import '../../shared/resourses/strings_manager.dart';
import 'home_cubit/home_cubit.dart';
import 'home_cubit/home_state.dart';
import 'home_widget/drawer_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: cubit.pateintMainModel != null,
              builder: (context) => Scaffold(
                    drawer: const DrawerBody(),
                    appBar: AppBar(
                      leading: appBarLeading(),
                      actions: [
                        popMenu(
                            cubit.popMenueItems(context),
                            appBarAction('hi ${cubit.pateintMainModel!.name}',
                                '$startPhoto${cubit.pateintMainModel!.profileImage}')),
                      ],
                    ),
                    body: SafeArea(
                      child: cubit.listPage[cubit.numPage],
                    ),
                    bottomNavigationBar:
                        curveNAvigationBar(cubit.listIcons, cubit),
                  ),
              fallback: (context) => Scaffold(
                  body: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                          color: ColorManager.primaryColor,
                          size: SizeManager.s30))));
        });
  }
}
