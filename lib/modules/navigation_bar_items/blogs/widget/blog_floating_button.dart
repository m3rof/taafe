
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:page_transition/page_transition.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/widget/add_category_screen.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/widget/add_post_blog_screen.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/widget/search_blog_screen.dart';
import 'package:taafe/shared/components/constants.dart';

import '../../../../shared/resourses/color_manager.dart';
import '../../../../shared/resourses/value_app.dart';

class BlogFloatingButton extends StatelessWidget {
  const BlogFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
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
            moveScreen(context: context, screen:const SearchBlogScreen());
          },
        ),
        SpeedDialChild(
          child:const Icon(Icons.add),
          shape:const CircleBorder(),
          onTap: () {
            moveScreen(context: context, screen:AddPostBlogScreen(1,0));
          },
        ),
        SpeedDialChild(
          child:const Icon(Icons.add),
          shape:const CircleBorder(),
          onTap: () {
            moveScreen(context: context, screen:const AddCategoryScreen());
          },
        ),
      ],
    );
  }
}
