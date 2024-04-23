import 'package:awesome_icons/awesome_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_state.dart';
import 'package:taafe/shared/network/remote/end_points.dart';
import 'package:taafe/shared/resourses/color_manager.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/resourses/styles.dart';
import '../../../../shared/resourses/value_app.dart';

class SearchBlogScreen extends StatelessWidget {
  const SearchBlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlogCubit.get(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorManager.primaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white)),
      body: BlocConsumer<BlogCubit, BlogState>(
        listener: (context, state) {},
        builder: (context, state) {
          print('mmmmmmmmm');
          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 18, bottom: 20),
              height: 120,
              decoration: BoxDecoration(
                  color: ColorManager.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Row(
                children: [
                  SizedBox(
                      width: 300,
                      child: searchField(
                          (value) => cubit.getSearchArticle(value), 'search')),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return BlocBuilder<BlogCubit, BlogState>(
                              builder: (context, state) {
                                print('aaaaaaaaaaa');
                                return Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                ListView.builder(
                                  itemBuilder: (context, index) =>
                                      InkWell(
                                        onTap: () {

                                          cubit.selectCategory(index);
                                          print('ssssssss ${cubit.isSelected}');
                                        },
                                        child: CategoryChoice(
                                            cubit.menuCategorySearch[index], cubit.isSelected,index,cubit),
                                      ),
                                  shrinkWrap: true,
                                  itemCount: cubit.menuCategorySearch.length,
                                )
                              ],
                            ),
                          );
  },
);
                        },
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Icon(
                          FontAwesomeIcons.slidersH,
                          color: Colors.orangeAccent,
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: SizeManager.s16,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Show Result :',
                  style: StylesManager.itemHome
                      .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start),
            ),
            const SizedBox(
              height: SizeManager.s16,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cubit.searchArticle.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: SizeManager.s10),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl:
                          '$startPhoto${cubit.searchArticle[index]['covorImage']}',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(cubit.searchArticle[index]['mainText'],
                        style: StylesManager.itemHome),
                  ),
                ),
              ),
            )
          ],
        );
        },
      ),
    );
  }
}

Widget CategoryChoice(String category, bool isSelected,int index,BlogCubit cubit) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(category,
            style: isSelected
                ? TextStyle(
                    color: ColorManager.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)
                : StylesManager.itemHome
                    .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start),
        isSelected ? Icon(Icons.check) : Text('')
      ],
    ),
  );
}
