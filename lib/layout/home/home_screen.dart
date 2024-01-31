import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/medical_record/mediacal_record_screen.dart';
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
    return Scaffold(
      drawer: const DrawerBody(),
      appBar: AppBar(
        leading: appBarLeading(),
        actions: [
          popMenu(cubit.popMenueItems(context), appBarAction(StringManager.hi, AssetsManager.me)),

        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) => SafeArea(
          child: cubit.listPage[cubit.numPage],
        ),
      ),
      bottomNavigationBar: curveNAvigationBar(cubit.listIcons, cubit),
    );
  }
}
