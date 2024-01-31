import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_state.dart';

import '../../../shared/components/components.dart';
import '../../../shared/resourses/strings_manager.dart';
import '../../../shared/resourses/value_app.dart';



class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlogCubit.get(context);
    return BlocConsumer<BlogCubit,BlogState>(
      listener: (context, state) {},
      builder:(context, state) => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleKind(context, StringManager.blogs),
                // searchKind(context, (){}, '${StringManager.Subject} ${StringManager.searchHint}'),
                const SizedBox(height: SizeManager.s14,),
                Padding(
                  padding: const EdgeInsets.only(left: SizeManager.s24, right: SizeManager.s22),
                  child: titleRow(context,'',(){},StringManager.filter),
                ),
                const SizedBox(height: SizeManager.s18),
              ],
            ) ,
          ),
          SliverToBoxAdapter(
            child: listViewBlogsV(context,cubit),
          )
        ],
      ),
    ) ;
  }
}




