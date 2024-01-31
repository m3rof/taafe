
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/resourses/strings_manager.dart';
import '../../../shared/resourses/value_app.dart';
import '../home_cubit/home_cubit.dart';
import '../home_cubit/home_state.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) => ListView(
        children: [
          const SizedBox(
            height: SizeManager.s20,
          ),
          titleHome(context),
          // searchKind(context, null,StringManager.search),
          const SizedBox(
            height: SizeManager.s20,
          ),
          listViewServices(context, cubit.listServices),
          const SizedBox(
            height: SizeManager.s12,
          ),
          listViewTherapists(context),
          const SizedBox(
            height: SizeManager.s12,
          ),
          listViewBlogs(context),
          const SizedBox(
            height: SizeManager.s12,
          ),
          listViewTest(context, cubit.listTest)
        ],
      ),
    );
  }
}
