
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:page_transition/page_transition.dart';
import 'package:taafe/modules/posts/add_post_screen.dart';

import 'package:taafe/modules/posts/posts_cubit/posts_cubit.dart';
import 'package:taafe/modules/posts/posts_cubit/posts_state.dart';
import 'package:taafe/modules/search/search_screen.dart';

import '../../shared/components/components.dart';
import '../../shared/resourses/color_manager.dart';
import '../../shared/resourses/strings_manager.dart';
import '../../shared/resourses/value_app.dart';

class PostsScreen extends StatelessWidget {
  int id;
  String nameCommunity;

  PostsScreen(this.id, this.nameCommunity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => PostsCubit()..getPostsList(id),
        child: BlocConsumer<PostsCubit, PostsState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = PostsCubit.get(context);
            if (cubit.post.isNotEmpty) {
              return CustomScrollView(
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
                            children: [Text(nameCommunity)],
                          ),
                          const SizedBox(
                            height: SizeManager.s20,
                          ),
                          titleRow(StringManager.sort),
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
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme:const IconThemeData(color: Colors.white),
        backgroundColor: ColorManager.headOrange,
        overlayColor: Colors.black,
        overlayOpacity: .4,
        spacing: SizeManager.s6,
        spaceBetweenChildren: SizeManager.s6,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.search_outlined),
            shape:const CircleBorder(),
            onTap: () {
              Navigator.of(context).push(PageTransition(
                  duration: const Duration(milliseconds: 600),
                  type: PageTransitionType.rightToLeft,
                  child:const SearchScreen()));
            },
          ),
          SpeedDialChild(
            child:const Icon(Icons.add),
            shape:const CircleBorder(),
            onTap: () {
              Navigator.of(context).push(PageTransition(
                  duration: const Duration(milliseconds: 600),
                  type: PageTransitionType.rightToLeft,
                  child: AddPostScreen(1,0)));
            },
          ),
        ],
      ),
    );
  }
}
