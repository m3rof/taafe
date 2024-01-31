import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/navigation_bar_items/communities/communites_cubit/community_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/communities/communites_cubit/community_state.dart';
import 'package:taafe/modules/posts/posts_cubit/posts_cubit.dart';
import 'package:taafe/modules/posts/posts_screen.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';

import '../../../shared/resourses/value_app.dart';

class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommunityCubit, CommunityState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CommunityInitialState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (state is CommunitySuccessState) {
          var cubit = CommunityCubit.get(context);
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(right: 22, left: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(StringManager.communities,
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(
                        height: SizeManager.s22,
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: cubit.community.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) => GridTile(
                      child: itemCommunity(() {
                        moveScreen(
                            context: context,
                            screen: PostsScreen(cubit.community[index]['id'],cubit.community[index]['name']));
                      },
                          cubit.community[index]['iconLink'] != null
                              ? '${cubit.community[index]['iconLink']}'
                              : AssetsManager.sad,

                          '${cubit.community[index]['name']}'),
                    ),
                  ),
                ),
              )
            ],
          );
        }
        else {
          return Center(
            child: Image.asset(AssetsManager.me),
          );
        }
      },
    );
  }
}
