import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/posts/add_post_screen.dart';
import 'package:taafe/modules/posts/posts_cubit/posts_cubit.dart';
import 'package:taafe/modules/posts/posts_cubit/posts_state.dart';

import '../../shared/components/components.dart';
import '../../shared/resourses/color_manager.dart';
import '../../shared/resourses/strings_manager.dart';
import '../../shared/resourses/value_app.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = PostsCubit.get(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {},
        builder: (context, state) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: SizeManager.s20, right: SizeManager.s22),
                child: Column(
                  children: [
                    const SizedBox(
                      height: SizeManager.s20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: searchKind(
                                context, () {}, StringManager.search,
                                right: SizeManager.s0, left: SizeManager.s0)),
                        const SizedBox(
                          width: SizeManager.s16,
                        ),
                        floatingButton(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddPostScreen(),
                              ));
                        },
                            const Icon(
                              Icons.add,
                              color: ColorManager.headOrange,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: SizeManager.s20,
                    ),
                    titleRow(context, '', () {}, StringManager.sort),
                    const SizedBox(
                      height: SizeManager.s20,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: listPosts(context, cubit),
            )
          ],
        ),
      ),
    );
  }
}
