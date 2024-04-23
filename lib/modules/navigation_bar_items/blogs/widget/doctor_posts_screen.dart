import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_state.dart';
import 'package:taafe/shared/components/components.dart';

import '../../../../shared/resourses/value_app.dart';



class DoctorPostsScreen extends StatelessWidget {
  const DoctorPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => BlogCubit()..getDoctorPosts(),
        child: BlocConsumer<BlogCubit, BlogState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = BlogCubit.get(context);
            if (cubit.doctorPosts.isNotEmpty) {
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
                    child: listDoctorPosts(context,cubit),
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
