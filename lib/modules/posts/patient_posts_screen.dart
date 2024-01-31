import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/shared/components/components.dart';

import '../../shared/resourses/value_app.dart';
import 'posts_cubit/posts_cubit.dart';
import 'posts_cubit/posts_state.dart';

class PatientPosts extends StatelessWidget {
  const PatientPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => PostsCubit()..getPatientPosts(),
        child: BlocConsumer<PostsCubit, PostsState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = PostsCubit.get(context);
            if (cubit.patientPost.isNotEmpty) {
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding:  EdgeInsets.only(
                          left: SizeManager.s20, right: SizeManager.s22),
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeManager.s20,
                          ),
                          Row(
                            children: [Text('My Posts')],
                          ),
                          SizedBox(
                            height: SizeManager.s20,
                          ),
                          SizedBox(
                            height: SizeManager.s20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: listPatientPosts(context,cubit),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
