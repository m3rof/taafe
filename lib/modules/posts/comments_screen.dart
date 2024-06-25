
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_state.dart';

import 'package:taafe/shared/components/components.dart';

import 'package:taafe/shared/resourses/styles.dart';

import '../../shared/network/remote/end_points.dart';
import '../../shared/resourses/value_app.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<BlogCubit, BlogState>(
        listener: (context, state) {},
        builder: (context, state) {
          //var cubit = BlogCubit.get(context);
          return Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) => itemCommentsCommunity(),
                  itemCount: 5));
        },
      ),
    );
  }
}

class itemCommentsCommunity extends StatelessWidget {
  // String namePublisher;
  // String doctorProfileImage;
  // String mainTitle;
  // String date;
  // int reaction;
  // bool reactionByUser;
  //
  // itemCommentsBlog(this.namePublisher, this.mainTitle, this.date, this.reaction,
  //     this.reactionByUser,this.doctorProfileImage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: SizeManager.s20, right: SizeManager.s22),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileImage(
                  image: NetworkImage(
                      'https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=1483'),
                  height: SizeManager.s65,
                  width: SizeManager.s65,
                  radius: SizeManager.s35),
              const SizedBox(
                width: SizeManager.s30,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(SizeManager.s6),
                  decoration: const BoxDecoration(
                    color: Colors.white38,
                    borderRadius:
                        BorderRadius.all(Radius.circular(SizeManager.s16)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mahmoud Gamal',
                        style: StylesManager.itemHome.copyWith(
                            fontSize: SizeManager.s20,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: SizeManager.s8,
                      ),
                      Text(
                        'osama and ashraf and omar omaromaromaromaromaromaromar',
                        style: StylesManager.itemHome
                            .copyWith(fontSize: SizeManager.s18),
                      ),
                      SizedBox(
                        height: SizeManager.s8,
                      ),
                      Row(
                        children: [
                          Text(
                            '2023-11-05',
                            style: StylesManager.or,
                          ),
                          const SizedBox(
                            width: SizeManager.s8,
                          ),
                          Spacer(),
                          LikeButton(
                            isLiked: true,
                            likeCount: 18,
                            likeBuilder: (isLiked) {
                              final Color color = Colors.grey;
                              return Icon(
                                Icons.favorite,
                                color: color,
                              );
                            },
                            countBuilder: (likeCount, isLiked, text) {
                              final Color color = Colors.grey;

                              return Text(
                                text,
                                style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          dividerBlue(
            width: 400,
            color: Colors.black12,
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}

  Widget itemCommentsBlog (String namePublisher,
  String doctorProfileImage,
  String mainTitle,
  String date,
  int reaction,
  bool reactionByUser,
  functionLikedComment()
      ){
  return Padding(
      padding:
          const EdgeInsets.only(left: SizeManager.s20, right: SizeManager.s22),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileImage(
                  image:
                      NetworkImage('$baseUrl/profilepic/${doctorProfileImage}'),
                  height: SizeManager.s65,
                  width: SizeManager.s65,
                  radius: SizeManager.s35),
              const SizedBox(
                width: SizeManager.s30,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(SizeManager.s6),
                  decoration: const BoxDecoration(
                    color: Colors.white38,
                    borderRadius:
                        BorderRadius.all(Radius.circular(SizeManager.s16)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namePublisher,
                        style: StylesManager.itemHome.copyWith(
                            fontSize: SizeManager.s20,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: SizeManager.s8,
                      ),
                      Text(
                        mainTitle,
                        style: StylesManager.itemHome
                            .copyWith(fontSize: SizeManager.s18),
                      ),
                      SizedBox(
                        height: SizeManager.s8,
                      ),
                      Row(
                        children: [
                          Builder(builder: (context) {
                            DateTime parseDate =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                    .parse(date);
                            return Text(
                              DateFormat('MM/dd/yyyy').format(parseDate),
                              style: StylesManager.or,
                            );
                          }),
                          const SizedBox(
                            width: SizeManager.s8,
                          ),
                          Spacer(),
                          likedComment(
                            false,
                            reaction,
                              functionLikedComment
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          dividerBlue(
            width: 400,
            color: Colors.black12,
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }


