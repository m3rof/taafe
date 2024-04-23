import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_state.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_screen.dart';
import 'package:taafe/shared/components/constants.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/resourses/assets_manager.dart';
import '../../../../shared/resourses/strings_manager.dart';
import '../../../../shared/resourses/value_app.dart';

class CategoryBlogScreen extends StatelessWidget {
  const CategoryBlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogCubit, BlogState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlogCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.category.isNotEmpty,
            builder: (context) => CustomScrollView(
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
                          itemCount: cubit.category.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) => GridTile(
                            child: itemCommunity(() {
                              moveScreen(
                                  context: context, screen: BlogsScreen(cubit.category[index]['id']));
                            },
                                cubit.category[index]['iconLink'] != null
                                    ? '${cubit.category[index]['iconLink']}'
                                    : AssetsManager.sad,
                                '${cubit.category[index]['category']}'),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
            fallback: (context) => loadingProgress());
      },
    );
  }
}
