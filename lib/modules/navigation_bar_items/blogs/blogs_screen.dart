import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_state.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/widget/blog_floating_button.dart';
import 'package:taafe/shared/components/constants.dart';

import '../../../shared/components/components.dart';
import '../../../shared/resourses/strings_manager.dart';
import '../../../shared/resourses/value_app.dart';

class BlogsScreen extends StatelessWidget {

   int categoryId;


  BlogsScreen(this.categoryId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => BlogCubit()..getListArticle(categoryId),
          child: BlocConsumer<BlogCubit, BlogState>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = BlogCubit.get(context);
                return ConditionalBuilder(
                    condition: cubit.listArticle.isNotEmpty,
                    builder: (context) => CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleKind(context, StringManager.blogs),
                                  const SizedBox(
                                    height: SizeManager.s14,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: SizeManager.s24,
                                        right: SizeManager.s22),
                                    child: titleRow(StringManager.filter),
                                  ),
                                  const SizedBox(height: SizeManager.s18),
                                ],
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: listViewBlogsV(context, cubit),
                            )
                          ],
                        ),
                    fallback: (context) => loadingProgress());
              }),
        ),
        floatingActionButton:const BlogFloatingButton() ,
    );
  }
}
