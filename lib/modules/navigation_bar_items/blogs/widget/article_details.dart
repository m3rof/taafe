
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_state.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/network/remote/end_points.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';

import '../../../../shared/components/constants.dart';
import '../../../posts/comments_screen.dart';

class ArticleDetails extends StatelessWidget {
  int articleId;

  ArticleDetails({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => BlogCubit()
          ..getArticleID(articleId)
          ..getCommentsID(articleId, 1),
        child: BlocConsumer<BlogCubit, BlogState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = BlogCubit.get(context);
            return ConditionalBuilder(
                condition:
                    cubit.blogArticleModel != null && cubit.comments != null,
                builder: (context) => CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        '$baseUrl/file/${cubit.blogArticleModel!.covorImage}',
                                    height: 300,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                  AppBar(
                                    backgroundColor: Colors.transparent,
                                    iconTheme:
                                        IconThemeData(color: Colors.white),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: 150,
                                            child: Text(
                                              cubit.blogArticleModel!.title,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color:
                                                      ColorManager.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                            height: 34,
                                            width: 68,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    234, 232, 232, 1.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                            child: likedArticled(false,
                                                cubit.blogArticleModel!.upVotes,
                                                () {
                                              cubit.makeAndDeleteLikeDoctor(
                                                  3, 1, false);
                                            }))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    dividerBlue(
                                        width: 400,
                                        color: ColorManager.greyColor,
                                        thickness: 1,
                                        height: 32),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            showImage(
                                                context, AssetsManager.me);
                                          },
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                ColorManager.primaryColor,
                                            backgroundImage: NetworkImage('$startPhoto${cubit
                                                .blogArticleModel!.doctorProfileImage}')
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              cubit
                                                  .blogArticleModel!.doctorName,
                                              style: StylesManager.itemHome
                                                  .copyWith(fontSize: 15),
                                            ),
                                            Builder(builder: (context) {
                                              String date =
                                                  cubit.blogArticleModel!.date;
                                              DateTime parseDate = DateFormat(
                                                      "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                                  .parse(date);
                                              return Text(
                                                DateFormat('MM/dd/yyyy')
                                                    .format(parseDate),
                                                style: StylesManager.or
                                                    .copyWith(fontSize: 13),
                                              );
                                            }),
                                          ],
                                        ),
                                        Spacer(),
                                        starsYellow(cubit
                                            .blogArticleModel!.doctorStarRate.toDouble())
                                      ],
                                    ),
                                    dividerBlue(
                                        width: 400,
                                        color: ColorManager.greyColor,
                                        thickness: 1,
                                        height: 32),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              cubit.blogArticleModel!.mainText,
                              style: StylesManager.itemHome,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: dividerBlue(
                                    width: 400,
                                    color: ColorManager.greyColor,
                                    thickness: 1,
                                    height: 32),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      itemCommentsBlog(
                                        cubit.comments[index]['doctorName'],
                                        cubit.comments[index]
                                            ['doctorProfileImage'],
                                        cubit.comments[index]['comment'],
                                        cubit.comments[index]['date'],
                                        cubit.comments[index]['likes'],
                                        true,
                                        () {
                                          cubit.makeAndDeleteLikeDoctorComment(1,cubit.comments[index]['id'],false);
                                        },
                                      ),
                                  itemCount: cubit.comments.length),
                            ],
                          ),
                        )
                      ],
                    ),
                fallback: (context) => loadingProgress());
          },
        ),
      ),
    );
  }
}
