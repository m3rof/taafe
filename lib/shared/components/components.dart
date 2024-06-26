import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/modules/about_doctor/about_doctor_screen.dart';

import 'package:taafe/modules/login/login_cubit/login_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/communities/communites_cubit/community_cubit.dart';
import 'package:taafe/modules/posts/posts_cubit/posts_cubit.dart';
import 'package:taafe/modules/search/search_cubit/search_cubit.dart';
import 'package:taafe/shared/network/remote/end_points.dart';

import '../../layout/home/home_cubit/home_cubit.dart';
import '../../modules/appointment_doctor/appointment_doctor_screen.dart';
import '../../modules/drawer_items/medicine_alarm/medicine_alarm_cubit/medicine_alarm_cubit.dart';
import '../../modules/navigation_bar_items/blogs/widget/article_details.dart';
import '../resourses/assets_manager.dart';
import '../resourses/color_manager.dart';
import '../resourses/strings_manager.dart';
import '../resourses/styles.dart';
import '../resourses/value_app.dart';
import 'constants.dart';

Widget logoLogin(context) {
  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: EdgeInsets.symmetric(
          vertical: hightMedia(context: context, h: SizeManager.s_05)),
      child: const Column(
        children: [
          Image(
            image: AssetImage(AssetsManager.logo),
            width: 200,
            height: 200,
          ),
          Image(
            image: AssetImage(AssetsManager.shadow),
            width: 200,
          ),
        ],
      ),
    ),
  );
}

Widget welcome() {
  return Text(
    StringManager.welcome,
    style: StylesManager.welcome,
  );
}

Widget textButton(
    {required function, required String text, required TextStyle textStyle}) {
  return InkWell(onTap: function, child: Text(text, style: textStyle));
}

Widget loginWith(function, String assets) {
  return InkWell(
    onTap: function,
    child: CircleAvatar(child: Image.asset(assets)),
  );
}

Widget loginIcon(LoginCubit loginCubit, context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      loginWith(null, AssetsManager.facebook),
      const SizedBox(
        width: SizeManager.s12,
      ),
      loginWith(null, AssetsManager.twitter),
      const SizedBox(
        width: SizeManager.s12,
      ),
      loginWith(() {
        try {
          final user = loginCubit.signInWithGoogle();
          if (user != null) {
            moveScreen(context: context, screen: HomeScreen());
          }
        } on FirebaseException catch (e) {
          print('eeeeeee ${e.message}');
        } catch (e) {
          print('ssssss ${e.toString()}');
        }
      }, AssetsManager.gmail),
    ],
  );
}

Widget userPhoto(function) {
  return InkWell(
    onTap: function,
    child: const CircleAvatar(
        backgroundColor: ColorManager.textWhite,
        radius: SizeManager.s40,
        child: Icon(
          Icons.account_circle,
          size: SizeManager.s58,
          color: ColorManager.greyColor,
        )),
  );
}

Widget line() {
  return Container(
    color: ColorManager.textWhite,
    width: SizeManager.s120,
    height: SizeManager.s3,
  );
}

Widget titleHome(context) {
  return Padding(
    padding:
        const EdgeInsets.only(left: SizeManager.s24, right: SizeManager.s22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringManager.find,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          height: SizeManager.s4,
        ),
        Text(
          StringManager.suitable,
          style: StylesManager.headPrimary1,
        ),
        const SizedBox(
          height: SizeManager.s10,
        ),
      ],
    ),
  );
}

Widget titleKind(context, String kind) {
  return Padding(
    padding:
        const EdgeInsets.only(left: SizeManager.s24, right: SizeManager.s22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          kind,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: SizeManager.s12,
        ),
        Text(
          '${StringManager.searchFor} $kind',
          style: StylesManager.headPrimary3
              .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: SizeManager.s10,
        ),
      ],
    ),
  );
}

Widget searchField(function(value), String hint) {
  return TextFormField(
    onChanged: (value) {
      function(value);
    },
    style: StylesManager.label,
    cursorColor: ColorManager.primaryColor,
    autofocus: true,
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.search_outlined),
      fillColor: Colors.white,
      filled: true,
      hintText: hint,
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      hintStyle: const TextStyle(color: ColorManager.primaryColor),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(SizeManager.s16)),
          borderSide: BorderSide(color: ColorManager.search)),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(SizeManager.s16)),
          borderSide: BorderSide(color: ColorManager.search)),
    ),
  );
}

Widget searchKind(
  context,
  function,
  String hint,
  SearchCubit cubit, {
  BlogCubit? blogCubit,
  CommunityCubit? communityCubit,
  double left = SizeManager.s24,
  double right = SizeManager.s22,
}) {
  return Padding(
    padding: EdgeInsets.only(left: left, right: right),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchField((value) => cubit.getSearchResult(value), hint),
        collectionDropFormField(
            validator: 'enter the category',
            selectedItem: cubit.selectedCategory,
            list: communityCubit!.name,
            function: (value) => cubit.showResult(
                value, cubit.selectedCategory, communityCubit.community),
            left: SizeManager.s10,
            right: SizeManager.s10,
            top: SizeManager.s10,
            bottom: SizeManager.s10,
            text: 'category'),
      ],
    ),
  );
}

Widget appBarLeading() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(width: SizeManager.s8),
      Builder(builder: (context) {
        return IconButton(
          icon: const Icon(Icons.menu_open_outlined),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }),
    ],
  );
}

Widget appBarAction(
  String name,
  String image,
) {
  return Row(
    children: [
      Text(name, style: StylesManager.hi),
      const SizedBox(
        width: SizeManager.s10,
      ),
      SizedBox(
        height: SizeManager.s24,
        width: SizeManager.s24,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: Image(
              fit: BoxFit.cover, image: NetworkImage('$startPhoto$image')),
        ),
      ),
      const SizedBox(
        width: SizeManager.s16,
      ),
    ],
  );
}

Widget itemServices(String assets, String name) {
  return Container(
    margin: const EdgeInsets.all(SizeManager.s10),
    width: 110,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s24)),
        border: Border.all(color: ColorManager.primaryColor, width: .7)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: SizeManager.s10),
        Image(height: SizeManager.s50, image: AssetImage(assets)),
        const SizedBox(
          height: SizeManager.s3,
        ),
        Text(
          textAlign: TextAlign.center,
          name,
          style: StylesManager.itemHome,
        )
      ],
    ),
  );
}

Widget listViewServices(context, List<ItemServices> list) {
  return Padding(
    padding:
        const EdgeInsets.only(left: SizeManager.s24, right: SizeManager.s22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringManager.services,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: SizeManager.s140,
          child: ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return itemServices(
                  list[index].assetsService, list[index].nameServices);
            },
          ),
        )
      ],
    ),
  );
}

Widget titleRow(String sort) {
  return Align(
    alignment: Alignment.topRight,
    child: Container(
      margin: const EdgeInsets.only(top: SizeManager.s2),
      padding: const EdgeInsets.all(SizeManager.s8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s14)),
        border: Border.all(color: ColorManager.primaryColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
            width: 20,
            child: Image(image: AssetImage(AssetsManager.sort)),
          ),
          const SizedBox(
            width: SizeManager.s4,
          ),
          Text(sort, style: StylesManager.category)
        ],
      ),
    ),
  );
}

Widget greenContainer(
    {required String text,
    required function,
    top = SizeManager.s6,
    left = SizeManager.s6,
    right = SizeManager.s6,
    bottom = SizeManager.s6,
    fontSize = SizeManager.s10}) {
  return InkWell(
    onTap: function,
    child: Container(
      padding:
          EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(SizeManager.s22)),
        color: Colors.green,
      ),
      child: Text(
        text,
        style: StylesManager.greenContainer.copyWith(fontSize: fontSize),
      ),
    ),
  );
}

Widget profileImage(
    {image,
    required double height,
    required double width,
    required double radius}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: ColorManager.primaryColor, width: 1),
        image: DecorationImage(
            image: image == null ? AssetImage(AssetsManager.me) : image,
            fit: BoxFit.cover)),
  );
}

Widget greenDone() {
  return Container(
    margin: const EdgeInsets.only(top: SizeManager.s6),
    width: SizeManager.s16,
    height: SizeManager.s16,
    child: const Image(
      image: AssetImage(AssetsManager.greenDone),
    ),
  );
}

Widget starsYellow(double rating) {
  return SmoothStarRating(
      allowHalfRating: true,
      halfFilledIconData: Icons.star_half,
      starCount: 5,
      rating: rating,
      size: 20.0,
      filledIconData: Icons.star,
      color: Colors.orange,
      borderColor: Colors.grey,
      spacing: 0.0);
}

Widget itemTherapists(context) {
  return InkWell(
    onTap: () {
      moveScreen(context: context, screen: const AboutDoctorScreen());
    },
    child: Container(
      margin: const EdgeInsets.all(SizeManager.s14),
      child: Column(
        children: [
          profileImage(
              height: SizeManager.s135,
              width: SizeManager.s135,
              radius: SizeManager.s84),
          const SizedBox(
            height: SizeManager.s12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: SizeManager.s150,
                      child: Text(
                        "Dr. John Lemon",
                        style: StylesManager.loginCreate,
                        overflow: TextOverflow.ellipsis,
                      )),
                  greenDone()
                ],
              ),
              SizedBox(
                  width: SizeManager.s150,
                  child: Text("Heart Sergeon",
                      style: StylesManager.or,
                      overflow: TextOverflow.ellipsis)),
              starsYellow(4),
              const SizedBox(
                height: SizeManager.s12,
              ),
              Text(
                StringManager.about,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                  height: SizeManager.s84,
                  width: SizeManager.s150,
                  child: Text(
                    StringManager.aboutContent,
                    style: StylesManager.or,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  )),
              const SizedBox(
                height: SizeManager.s8,
              ),
              greenContainer(text: StringManager.appointment, function: null)
            ],
          )
        ],
      ),
    ),
  );
}

Widget listViewTherapists(context) {
  return Padding(
    padding:
        const EdgeInsets.only(left: SizeManager.s24, right: SizeManager.s22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleRow(StringManager.sort),
        const SizedBox(height: SizeManager.s4),
        SizedBox(
          height: SizeManager.s400,
          child: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return itemTherapists(context);
            },
          ),
        )
      ],
    ),
  );
}

Widget blueContainer(
    {function,
    double height = SizeManager.s20,
    double pLeft = SizeManager.s0,
    double pTop = SizeManager.s0,
    double pRight = SizeManager.s0,
    double pButton = SizeManager.s0,
    double left = SizeManager.s0,
    double top = SizeManager.s0,
    double width = SizeManager.s58,
    double fontSize = SizeManager.s10,
    required double radius,
    required String text}) {
  return InkWell(
    onTap: function,
    child: Container(
      padding: EdgeInsets.only(
          top: pTop, left: pLeft, right: pRight, bottom: pButton),
      margin: EdgeInsets.only(left: left, top: top),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        color: ColorManager.primaryColor,
      ),
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: StylesManager.greenContainer.copyWith(fontSize: fontSize),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget itemBlogs(context) {
  return Container(
    margin: const EdgeInsets.all(SizeManager.s8),
    width: SizeManager.s200,
    height: SizeManager.s300,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(SizeManager.s30)),
        color: Colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 190,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsManager.session),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(SizeManager.s30),
            ),
          ),
        ),
        const SizedBox(height: SizeManager.s3),
        Text(
          StringManager.depression,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.orange,
              fontWeight: FontWeight.w600,
              fontSize: SizeManager.s18),
        ),
        const SizedBox(height: SizeManager.s2),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dr. mahmouh hanafi', style: StylesManager.drContent),
                const SizedBox(
                  height: SizeManager.s3,
                ),
                Container(
                  width: SizeManager.s120,
                  height: SizeManager.s_7,
                  color: ColorManager.primaryColor,
                ),
                const SizedBox(
                  height: SizeManager.s3,
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    'The head of psychology department - alex university',
                    style: StylesManager.drContent.copyWith(
                      fontSize: 10,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            blueContainer(
                function: null,
                left: SizeManager.s10,
                top: SizeManager.s10,
                radius: SizeManager.s12,
                text: StringManager.read)
          ],
        )
      ],
    ),
  );
}

Widget listViewBlogs(context) {
  return Padding(
    padding:
        const EdgeInsets.only(left: SizeManager.s24, right: SizeManager.s22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleRow(StringManager.sort),
        const SizedBox(height: SizeManager.s18),
        SizedBox(
          height: SizeManager.s300,
          child: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return itemBlogs(context);
            },
          ),
        )
      ],
    ),
  );
}

Widget itemTests(String assets, function) {
  return InkWell(
    onTap: function,
    child: Container(
      height: 100,
      width: 100,
      margin: const EdgeInsets.all(SizeManager.s6),
      decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage(assets))),
    ),
  );
}

Widget listViewTest(context, List<ItemTest> list) {
  return Padding(
    padding:
        const EdgeInsets.only(left: SizeManager.s24, right: SizeManager.s22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringManager.tests,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: SizeManager.s18),
        SizedBox(
          height: SizeManager.s120,
          child: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return itemTests(list[index].assetsService, list[index].function);
            },
          ),
        )
      ],
    ),
  );
}

Widget curveNAvigationBar(List<Widget> listIcons, cubit) {
  return CurvedNavigationBar(
    backgroundColor: ColorManager.primaryColor,
    animationDuration: const Duration(milliseconds: 300),
    height: SizeManager.s65,
    items: listIcons,
    index: cubit.numPage,
    onTap: (value) => cubit.changePage(value),
  );
}

Widget listViewTherapistsV(context) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 10,
    itemBuilder: (context, index) {
      return itemTherapistsV(context);
    },
  );
}

Widget itemTherapistsV(context) {
  return Container(
    padding: const EdgeInsets.all(SizeManager.s10),
    margin: const EdgeInsets.all(SizeManager.s14),
    height: SizeManager.s260,
    decoration: BoxDecoration(
      border:
          Border.all(color: ColorManager.primaryColor, width: SizeManager.s_7),
      borderRadius: const BorderRadius.all(
        Radius.circular(SizeManager.s10),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            profileImage(
                height: SizeManager.s75,
                width: SizeManager.s75,
                radius: SizeManager.s55),
            const SizedBox(width: SizeManager.s10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Dr. John Lemon',
                        style: StylesManager.headPrimary3,
                      ),
                      const SizedBox(
                        width: SizeManager.s4,
                      ),
                      greenDone()
                    ],
                  ),
                  const SizedBox(
                    height: SizeManager.s2,
                  ),
                  Row(
                    children: [
                      Text(
                        'Pyschologist',
                        style: StylesManager.itemHome
                            .copyWith(fontSize: SizeManager.s16),
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.user,
                            size: SizeManager.s14,
                          ),
                          Text(
                            '+1000 sessions',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: SizeManager.s10,
                                    fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: SizeManager.s2,
                  ),
                  starsYellow(5),
                  const SizedBox(
                    height: SizeManager.s2,
                  ),
                  Text(
                    '4.78 (1,354 reviews)',
                    style: StylesManager.or.copyWith(fontSize: SizeManager.s11),
                  )
                ],
              ),
            ),
          ],
        ),
        Text(
          StringManager.interests,
          style: StylesManager.itemHome.copyWith(fontSize: SizeManager.s12),
        ),
        const SizedBox(
          height: SizeManager.s4,
        ),
        Row(
          children: [
            blueContainer(
                function: null,
                radius: SizeManager.s4,
                text: StringManager.depressionTherapists),
            const SizedBox(
              width: SizeManager.s4,
            ),
            blueContainer(
                function: null,
                radius: SizeManager.s4,
                text: StringManager.anxietyTherapists),
            const SizedBox(
              width: SizeManager.s4,
            ),
            blueContainer(
                function: null,
                radius: SizeManager.s4,
                text: StringManager.moodTherapists,
                width: SizeManager.s76),
          ],
        ),
        const SizedBox(
          height: SizeManager.s4,
        ),
        Text(
          StringManager.about,
          style: StylesManager.itemHome.copyWith(fontSize: SizeManager.s12),
        ),
        const SizedBox(
          height: SizeManager.s4,
        ),
        Row(
          children: [
            SizedBox(
              width: 200,
              height: 30,
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipisicing Lorem ipsum dolor sit amet,',
                style: StylesManager.or.copyWith(fontSize: SizeManager.s11),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: SizeManager.s14,
            ),
            InkWell(
                onTap: () {},
                child: Text(StringManager.view,
                    style: StylesManager.drContent.copyWith(
                      fontSize: 10,
                    ))),
          ],
        ),
        const SizedBox(
          height: SizeManager.s4,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                    width: SizeManager.s14,
                    height: SizeManager.s14,
                    child: Image(image: AssetImage(AssetsManager.date))),
                const SizedBox(
                  width: SizeManager.s4,
                ),
                Text(
                  'Sun, Mon, Tue, Thu ( 6- 8 pm)',
                  style: StylesManager.or.copyWith(fontSize: SizeManager.s10),
                ),
              ],
            ),
            const SizedBox(
              height: SizeManager.s10,
            ),
            Row(
              children: [
                const SizedBox(
                    width: SizeManager.s14,
                    height: SizeManager.s14,
                    child: Image(image: AssetImage(AssetsManager.dollar))),
                const SizedBox(
                  width: SizeManager.s2,
                ),
                Text(
                  '30 USD / 30 min',
                  style: StylesManager.itemHome
                      .copyWith(fontSize: SizeManager.s10),
                ),
                const SizedBox(
                  width: SizeManager.s10,
                ),
                Text(
                  '50 USD / 60 min',
                  style: StylesManager.itemHome
                      .copyWith(fontSize: SizeManager.s10),
                ),
                const Spacer(),
                greenContainer(
                    text: StringManager.appointment,
                    function: () {},
                    bottom: SizeManager.s4,
                    top: SizeManager.s4,
                    left: SizeManager.s4,
                    right: SizeManager.s4,
                    fontSize: SizeManager.s8)
              ],
            )
          ],
        )
      ],
    ),
  );
}

Widget listViewBlogsV(context, BlogCubit cubit) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: cubit.listArticle.length,
    itemBuilder: (context, index) {
      return itemBlogsV(
          context: context,
          mainText: cubit.listArticle[index]['mainText'],
          image: '$baseUrl/file/${cubit.listArticle[index]['covorImage']}',
          title: cubit.listArticle[index]['title'],
          doctorName: cubit.listArticle[index]['doctorName'],
          articleID: cubit.listArticle[index]['id']);
    },
  );
}

Widget itemBlogsV(
    {context,
    required String image,
    required String mainText,
    required String title,
    required int articleID,
    required String doctorName}) {
  return InkWell(
    onTap: () {
      moveScreen(
          context: context,
          screen: ArticleDetails(
            articleId: articleID,
          ));
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
      margin: const EdgeInsets.all(SizeManager.s14),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(SizeManager.s30)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeManager.s200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(image), fit: BoxFit.fill),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(SizeManager.s30),
                topLeft: Radius.circular(SizeManager.s30),
              ),
            ),
          ),
          const SizedBox(height: SizeManager.s8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
                fontSize: SizeManager.s20),
          ),
          const SizedBox(height: SizeManager.s3),
          SizedBox(
            height: 50,
            child: Text(mainText,
                style:
                    StylesManager.itemHome.copyWith(fontSize: SizeManager.s14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: SizeManager.s2),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctorName, style: StylesManager.drContent),
                  const SizedBox(
                    height: SizeManager.s3,
                  ),
                  Container(
                    width: SizeManager.s120,
                    height: SizeManager.s_7,
                    color: ColorManager.primaryColor,
                  ),
                  const SizedBox(
                    height: SizeManager.s3,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      'The head of psychology department - alex university',
                      style: StylesManager.drContent.copyWith(
                        fontSize: 12,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(
                    height: SizeManager.s10,
                  ),
                ],
              ),
              const Spacer(),
              blueContainer(
                  function: null,
                  left: SizeManager.s10,
                  top: SizeManager.s10,
                  radius: SizeManager.s12,
                  text: StringManager.read)
            ],
          )
        ],
      ),
    ),
  );
}

Widget itemCommunity(function, String icon, String text) {
  return InkWell(
    onTap: function,
    child: Container(
      padding: const EdgeInsets.all(10),
      width: SizeManager.s135,
      decoration: BoxDecoration(
        border: Border.all(
            color: ColorManager.primaryColor, width: SizeManager.s_7),
        borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s22)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: SizeManager.s20,
          ),
          CachedNetworkImage(
              imageUrl: icon,
              width: SizeManager.s50,
              height: SizeManager.s50,
              errorWidget: (context, url, error) => const Icon(Icons.error)),
          const SizedBox(
            height: SizeManager.s10,
          ),
          Expanded(
            child: Text(
              text,
              style: StylesManager.itemHome,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
  );
}

Widget rowCommunity(item1, item2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [item1, item2],
  );
}

Widget floatingButton(function, Widget widget,
    {double width = SizeManager.s40, double height = SizeManager.s40}) {
  return SizedBox(
    width: width,
    height: height,
    child: FloatingActionButton(
      onPressed: function,
      backgroundColor: ColorManager.textWhite,
      child: widget,
    ),
  );
}

Widget quetsionDesigen(String content) {
  return Container(
    padding: const EdgeInsets.all(SizeManager.s8),
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(SizeManager.s16)),
        color: ColorManager.backGrey),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringManager.q,
          style: StylesManager.bodySmall.copyWith(fontSize: SizeManager.s20),
        ),
        Text(
          content,
          style: StylesManager.headPrimary3,
        ),
      ],
    ),
  );
}

Widget asnwerDesigen(String content) {
  return Container(
    padding: const EdgeInsets.all(SizeManager.s8),
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(SizeManager.s16)),
        color: ColorManager.backGrey),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringManager.a,
          style: StylesManager.bodySmall.copyWith(fontSize: SizeManager.s20),
        ),
        Text(content, style: StylesManager.loginCreate),
      ],
    ),
  );
}

Widget qADesign(String quetion, String answer, String answerBy, String job) {
  return Container(
    padding: const EdgeInsets.all(SizeManager.s8),
    margin: const EdgeInsets.all(SizeManager.s8),
    decoration: BoxDecoration(
        border:
            Border.all(color: ColorManager.headOrange, width: SizeManager.s_7),
        borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s10))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              StringManager.category,
              style: StylesManager.category,
            ),
            const SizedBox(
              width: SizeManager.s2,
            ),
            Text(
              'Depression Disorders',
              style: StylesManager.category,
            )
          ],
        ),
        const SizedBox(
          height: SizeManager.s6,
        ),
        quetsionDesigen(quetion),
        const SizedBox(
          height: SizeManager.s10,
        ),
        asnwerDesigen(answer),
        const SizedBox(
          height: SizeManager.s4,
        ),
        Row(
          children: [
            const Text(
              StringManager.answer,
              style: TextStyle(
                  color: ColorManager.greenColor, fontSize: SizeManager.s10),
            ),
            const SizedBox(
              width: SizeManager.s8,
            ),
            const Icon(
              Icons.account_circle,
              size: SizeManager.s16,
              color: ColorManager.headOrange,
            ),
            const SizedBox(
              width: SizeManager.s4,
            ),
            Text(
              answerBy,
              style: const TextStyle(
                  color: ColorManager.greenColor, fontSize: SizeManager.s14),
            ),
          ],
        ),
        Container(
          width: SizeManager.s150,
          color: ColorManager.primaryColor,
          height: SizeManager.s1,
        ),
        const SizedBox(
          height: SizeManager.s2,
        ),
        Text(
          job,
          style: const TextStyle(
              fontSize: SizeManager.s10, color: ColorManager.primaryColor),
        )
      ],
    ),
  );
}

Widget listViewQAV(String quetion, String answer, String answerBy, String job) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 10,
    itemBuilder: (context, index) {
      return qADesign(quetion, answer, answerBy, job);
    },
  );
}

Widget testLogoScreen(context, function) {
  return Column(
    children: [
      SizedBox(
        height: hightMedia(context: context, h: SizeManager.s_07),
      ),
      const AspectRatio(
          aspectRatio: 16 / 9,
          child: Image(image: AssetImage(AssetsManager.testLogo))),
      SizedBox(
        height: hightMedia(context: context, h: SizeManager.s_01),
      ),
      InkWell(
          onTap: function,
          child: const SizedBox(
              height: SizeManager.s250,
              width: SizeManager.s250,
              child: Image(image: AssetImage(AssetsManager.testStart))))
    ],
  );
}

Widget itemDrawer(context, icon, title, function) {
  return InkWell(
    onTap: function,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: ColorManager.headOrange,
              size: SizeManager.s20,
            ),
            const SizedBox(
              width: SizeManager.s16,
            ),
            Text(
              title,
              style: StylesManager.headPrimary3
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            const Icon(
              Icons.navigate_next,
              color: ColorManager.headOrange,
              size: SizeManager.s24,
            ),
          ],
        ),
        const SizedBox(
          height: SizeManager.s4,
        ),
        dividerBlue(width: widthMedia(context: context, x: SizeManager.s_51)),
        const SizedBox(
          height: 25,
        )
      ],
    ),
  );
}

Widget dividerBlue(
    {required double width,
    double height = 4,
    Color color = ColorManager.primaryColor,
    double thickness = 1}) {
  return SizedBox(
    width: width,
    child: Divider(
      color: color,
      height: height,
      thickness: thickness,
    ),
  );
}

Widget medicalRecordItem(
    {context,
    required IconData icon,
    required String title,
    required String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, color: ColorManager.headOrange),
          const SizedBox(width: SizeManager.s14),
          Text(
            title,
            style: StylesManager.headPrimary3,
          )
        ],
      ),
      const SizedBox(height: SizeManager.s10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: SizeManager.s300,
            child: Column(
              children: [
                Text(
                  value,
                  style: StylesManager.itemHome
                      .copyWith(fontSize: SizeManager.s16),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: SizeManager.s10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          dividerBlue(
              width: widthMedia(context: context, x: SizeManager.s_4),
              color: ColorManager.greenColor),
          const SizedBox(
            height: SizeManager.s20,
          ),
        ],
      )
    ],
  );
}



Widget itemSetting(context, icon, title, function) {
  return InkWell(
    onTap: function,
    child: Padding(
      padding: const EdgeInsets.only(left: SizeManager.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: ColorManager.headOrange,
                size: SizeManager.s20,
              ),
              const SizedBox(
                width: SizeManager.s16,
              ),
              Text(
                title,
                style: StylesManager.headPrimary3
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              const Icon(
                Icons.navigate_next,
                color: ColorManager.headOrange,
                size: SizeManager.s24,
              ),
            ],
          ),
          const SizedBox(
            height: SizeManager.s4,
          ),
          dividerBlue(width: widthMedia(context: context, x: SizeManager.s_7)),
          SizedBox(
            height: hightMedia(context: context, h: SizeManager.s_07),
          )
        ],
      ),
    ),
  );
}

Widget onlineTherapists() {
  return Container(
      margin: const EdgeInsets.symmetric(horizontal: SizeManager.s12),
      child: Column(
        children: [
          profileImage(
              height: SizeManager.s84,
              width: SizeManager.s84,
              radius: SizeManager.s50),
          const SizedBox(height: SizeManager.s8),
          SizedBox(
              width: SizeManager.s65,
              height: SizeManager.s65,
              child: Text(
                'Dr. Ahmed Marouf',
                style:
                    StylesManager.itemHome.copyWith(fontSize: SizeManager.s14),
              ))
        ],
      ));
}

Widget textFormGrey(
    {required TextEditingController textEditingController,
    required String validator,
    required TextInputType textInputType,
    required double left,
    required double right,
    required double top,
    required double bottom,
    Widget? icon}) {
  return TextFormField(
    controller: textEditingController,
    validator: (value) => value!.trim().isEmpty ? validator : null,
    keyboardType: textInputType,
    style: StylesManager.label.copyWith(color: Colors.black87),
    cursorColor: ColorManager.primaryColor,
    decoration: InputDecoration(
        suffixIcon: icon,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(left, top, right, bottom),
        fillColor: const Color(0xffe6e3ee),
        filled: true,
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeManager.s16)),
            borderSide: BorderSide(color: ColorManager.transparentColor)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeManager.s16)),
            borderSide: BorderSide(color: ColorManager.transparentColor)),
        border: const OutlineInputBorder()),
  );
}

Widget collectionTextFormGrey(
    {required String title,
    required TextEditingController textEditingController,
    required String validator,
    required TextInputType textInputType,
    required double left,
    required double right,
    required double top,
    required double bottom,
    Widget? icon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: StylesManager.itemHome,
      ),
      const SizedBox(
        height: SizeManager.s10,
      ),
      textFormGrey(
          textEditingController: textEditingController,
          validator: validator,
          textInputType: textInputType,
          left: left,
          right: right,
          top: top,
          bottom: bottom),
      const SizedBox(
        height: SizeManager.s18,
      ),
    ],
  );
}

Widget listViewAppointmentV(context) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 10,
    itemBuilder: (context, index) {
      return itemAppointmentV(context);
    },
  );
}

Widget itemAppointmentV(context) {
  return Container(
    padding: const EdgeInsets.all(SizeManager.s10),
    margin: const EdgeInsets.all(SizeManager.s14),
    width: SizeManager.s84,
    decoration: BoxDecoration(
      border:
          Border.all(color: ColorManager.primaryColor, width: SizeManager.s_7),
      borderRadius: const BorderRadius.all(
        Radius.circular(SizeManager.s10),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            profileImage(
                height: SizeManager.s75,
                width: SizeManager.s75,
                radius: SizeManager.s55),
            const SizedBox(width: SizeManager.s10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Dr. John Lemon',
                      style: StylesManager.headPrimary3,
                    ),
                    const SizedBox(
                      width: SizeManager.s4,
                    ),
                    greenDone()
                  ],
                ),
                const SizedBox(
                  height: SizeManager.s2,
                ),
                Text(
                  'Pyschologist',
                  style: StylesManager.itemHome
                      .copyWith(fontSize: SizeManager.s16),
                ),
                const SizedBox(
                  height: SizeManager.s2,
                ),
                const SizedBox(
                  height: SizeManager.s2,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: SizeManager.s10,
        ),
        Text(
          StringManager.interests,
          style: StylesManager.itemHome.copyWith(fontSize: SizeManager.s12),
        ),
        const SizedBox(
          height: SizeManager.s4,
        ),
        Row(
          children: [
            blueContainer(
                function: null,
                radius: SizeManager.s4,
                text: StringManager.depressionTherapists),
            const SizedBox(
              width: SizeManager.s4,
            ),
            blueContainer(
                function: null,
                radius: SizeManager.s4,
                text: StringManager.anxietyTherapists),
            const SizedBox(
              width: SizeManager.s4,
            ),
            blueContainer(
                function: null,
                radius: SizeManager.s4,
                text: StringManager.moodTherapists,
                width: SizeManager.s76),
          ],
        ),
        const SizedBox(
          height: SizeManager.s4,
        ),
        Text(
          StringManager.about,
          style: StylesManager.itemHome.copyWith(fontSize: SizeManager.s12),
        ),
        const SizedBox(
          height: SizeManager.s4,
        ),
        Row(
          children: [
            SizedBox(
              width: 200,
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipisicing Lorem ipsum dolor sit amet,',
                style: StylesManager.or.copyWith(fontSize: SizeManager.s11),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: SizeManager.s14,
            ),
            InkWell(
                onTap: () {},
                child: Text(StringManager.view,
                    style: StylesManager.drContent.copyWith(
                      fontSize: 10,
                    ))),
          ],
        ),
        const SizedBox(
          height: SizeManager.s10,
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: greenContainer(text: 'Tue/30 Aug 4:00 pm', function: () {}))
      ],
    ),
  );
}

Widget aboutItemDoctor(iconData, String text) {
  return Container(
    width: SizeManager.s150,
    padding: const EdgeInsets.all(SizeManager.s4),
    decoration: const BoxDecoration(color: Colors.white),
    child: Row(
      children: [
        iconData == null
            ? const SizedBox(
                width: SizeManager.s18,
                height: SizeManager.s18,
                child: Image(image: AssetImage(AssetsManager.dollar)))
            : Icon(iconData, color: ColorManager.headOrange),
        const SizedBox(
          width: SizeManager.s8,
        ),
        Text(text,
            style: StylesManager.itemHome.copyWith(
                fontSize: SizeManager.s10, fontWeight: FontWeight.w500))
      ],
    ),
  );
}

Widget nameDoctorAndJob() {
  return Column(
    children: [
      Align(
          alignment: Alignment.center,
          child: Text(
            'Dr. Vanadis Odindatter',
            style:
                StylesManager.headPrimary2.copyWith(fontSize: SizeManager.s28),
          )),
      const SizedBox(
        height: SizeManager.s10,
      ),
      Align(
          alignment: Alignment.center,
          child: Text(
            'Pyschologist',
            style: StylesManager.itemHome,
          )),
      const SizedBox(
        height: SizeManager.s22,
      ),
    ],
  );
}

Widget itemReview() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: SizeManager.s10),
    padding: const EdgeInsets.all(SizeManager.s6),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(SizeManager.s10))),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              'Jane Doe',
              style: StylesManager.itemHome,
            ),
            const SizedBox(
              width: SizeManager.s10,
            ),
            Text(
              '21 / 03 / 2023',
              style: StylesManager.or,
            ),
            starsYellow(1)
          ],
        ),
        const SizedBox(
          height: SizeManager.s8,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Lorem ipsum dolor sit amet. consectetuer elit.',
              style: StylesManager.itemHome,
            ))
      ],
    ),
  );
}

Widget listReview() {
  return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) => itemReview());
}

Widget moreReviews(function) {
  return InkWell(
    onTap: function,
    child: Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(SizeManager.s10),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'more reviews',
              style: TextStyle(
                  color: ColorManager.greenColor, fontSize: SizeManager.s16),
            ),
            SizedBox(
              width: SizeManager.s10,
            ),
            Icon(Icons.arrow_right)
          ],
        ),
      ),
    ),
  );
}

Widget achievement(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: SizeManager.s10),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalDivider(
            color: ColorManager.primaryColor,
            thickness: SizeManager.s3,
            width: 10,
          ),
          const SizedBox(
            width: SizeManager.s16,
          ),
          SizedBox(
              width: SizeManager.s200,
              child: Text(
                text,
                style: StylesManager.itemHome,
              ))
        ],
      ),
    ),
  );
}

Widget aboutDoctor(context) {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: ColorManager.textWhite,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeManager.s22),
          topRight: Radius.circular(SizeManager.s22)),
    ),
    child: Padding(
      padding:
          const EdgeInsets.only(left: SizeManager.s14, right: SizeManager.s14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: SizeManager.s20),
          nameDoctorAndJob(),
          Text('About',
              style: StylesManager.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500, fontSize: SizeManager.s22)),
          const SizedBox(
            height: SizeManager.s10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: hightMedia(context: context, h: SizeManager.s_21),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euy.',
                  style: StylesManager.or.copyWith(fontSize: SizeManager.s16),
                ),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  aboutItemDoctor(Icons.location_on_outlined, 'Umea, Sweden '),
                  const SizedBox(
                    height: SizeManager.s10,
                  ),
                  aboutItemDoctor(Icons.watch_later_outlined, '25 mins est.'),
                  const SizedBox(
                    height: SizeManager.s10,
                  ),
                  aboutItemDoctor(null, '25 USD / 232 SEK'),
                  const SizedBox(
                    height: SizeManager.s10,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: SizeManager.s16,
          ),
          Align(
              alignment: Alignment.center,
              child: dividerBlue(
                  width: hightMedia(context: context, h: SizeManager.s_21),
                  color: ColorManager.greenColor)),
          const SizedBox(
            height: 20,
          ),
          Text('Patient Reviews',
              style: StylesManager.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500, fontSize: SizeManager.s22)),
          listReview(),
          const SizedBox(
            height: SizeManager.s10,
          ),
          moreReviews(null),
          const SizedBox(
            height: SizeManager.s16,
          ),
          Align(
              alignment: Alignment.center,
              child: dividerBlue(
                  width: hightMedia(context: context, h: SizeManager.s_21),
                  color: ColorManager.greenColor)),
          const SizedBox(
            height: 20,
          ),
          Text('Experince',
              style: StylesManager.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500, fontSize: SizeManager.s22)),
          const SizedBox(
            height: SizeManager.s18,
          ),
          achievement(
              'Clinical training Mental Meaith Secrets Mar 2017 - Sep 20 18'),
          achievement(
              'Clinical training Mental Meaith Secrets Mar 2017 - Sep 20 18'),
          achievement(
              'Clinical training Mental Meaith Secrets Mar 2017 - Sep 20 18'),
          Align(
              alignment: Alignment.center,
              child: dividerBlue(
                  width: hightMedia(context: context, h: SizeManager.s_21),
                  color: ColorManager.greenColor)),
          const SizedBox(
            height: 20,
          ),
          Text('Certificate',
              style: StylesManager.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500, fontSize: SizeManager.s22)),
          const SizedBox(
            height: SizeManager.s18,
          ),
          achievement(
              'Clinical training Mental Meaith Secrets Mar 2017 - Sep 20 18'),
          achievement(
              'Clinical training Mental Meaith Secrets Mar 2017 - Sep 20 18'),
          achievement(
              'Clinical training Mental Meaith Secrets Mar 2017 - Sep 20 18'),
          Align(
              alignment: Alignment.center,
              child: dividerBlue(
                  width: hightMedia(context: context, h: SizeManager.s_21),
                  color: ColorManager.greenColor)),
          const SizedBox(
            height: 20,
          ),
          Text('Education',
              style: StylesManager.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500, fontSize: SizeManager.s22)),
          const SizedBox(
            height: SizeManager.s18,
          ),
          achievement(
              'Clinical training Mental Meaith Secrets Mar 2017 - Sep 20 18'),
          achievement(
              'Clinical training Mental Meaith Secrets Mar 2017 - Sep 20 18'),
          achievement(
              'Clinical training Mental Meaith Secrets Mar 2017 - Sep 20 18'),
          const SizedBox(
            height: SizeManager.s35,
          ),
          Align(
              alignment: Alignment.center,
              child: greenContainer(
                  text: 'Make an appointment_doctor',
                  function: () {
                    moveScreen(
                        context: context,
                        screen: const AppointmentDoctorScreen());
                  },
                  top: SizeManager.s10,
                  left: SizeManager.s10,
                  right: SizeManager.s10,
                  bottom: SizeManager.s10,
                  fontSize: SizeManager.s18)),
          const SizedBox(
            height: SizeManager.s35,
          ),
        ],
      ),
    ),
  );
}

Widget dropFormField(
    {required String? selectedItem,
    required String validator,
    required List list,
    required void function(value),
    required double left,
    required double right,
    required double top,
    required double bottom,
    GlobalKey<FormFieldState>? key}) {
  return DropdownButtonFormField(
    key: key,
    validator: (value) => value == null ? validator : null,
    value: selectedItem,
    items: list.map((e) {
      return DropdownMenuItem(
        value: e,
        child: Text(e),
      );
    }).toList(),
    onChanged: (value) {
      function(value);
    },
    icon: const Icon(
      Icons.arrow_drop_down_outlined,
      color: ColorManager.headOrange,
    ),
    dropdownColor: const Color(0xffe6e3ee),
    decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(left, top, right, bottom),
        fillColor: const Color(0xffe6e3ee),
        filled: true,
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeManager.s16)),
            borderSide: BorderSide(color: ColorManager.transparentColor)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeManager.s16)),
            borderSide: BorderSide(color: ColorManager.transparentColor)),
        border: const OutlineInputBorder()),
  );
}

Widget collectionDropFormField({
  required String text,
  required String validator,
  required String? selectedItem,
  required List list,
  required void function(value),
  required double left,
  required double right,
  required double top,
  required double bottom,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: StylesManager.itemHome,
      ),
      const SizedBox(
        height: SizeManager.s10,
      ),
      dropFormField(
          validator: validator,
          selectedItem: selectedItem,
          list: list,
          function: function,
          left: left,
          right: right,
          top: top,
          bottom: bottom),
      const SizedBox(
        height: SizeManager.s18,
      ),
    ],
  );
}

Widget itemAlarm(MedicineAlarmCubit cubit) {
  return Container(
    margin: const EdgeInsets.symmetric(
        horizontal: SizeManager.s10, vertical: SizeManager.s14),
    padding: const EdgeInsets.symmetric(
        vertical: SizeManager.s4, horizontal: SizeManager.s10),
    decoration: const BoxDecoration(
        color: ColorManager.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(SizeManager.s20))),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              MedicineAlarmCubit.medicineAlarm[0].name,
              style: StylesManager.greenContainer
                  .copyWith(fontSize: SizeManager.s24),
            ),
            Row(
              children: [
                Text(
                  MedicineAlarmCubit.medicineAlarm[0].clock,
                  style: StylesManager.greenContainer
                      .copyWith(fontSize: SizeManager.s18),
                ),
                const SizedBox(
                  width: SizeManager.s4,
                ),
                Text(
                  '(${MedicineAlarmCubit.medicineAlarm[0].day})',
                  style: StylesManager.greenContainer
                      .copyWith(fontSize: SizeManager.s18),
                ),
                const SizedBox(
                  height: SizeManager.s4,
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            Switch(
              value: MedicineAlarmCubit.medicineAlarm[0].turn,
              onChanged: (value) => cubit.changeTurn(),
              activeColor: ColorManager.headOrange,
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white,
            ),
            Text(
              MedicineAlarmCubit.medicineAlarm[0].turn == true ? 'ON' : 'OFF',
              style: StylesManager.greenContainer
                  .copyWith(fontSize: SizeManager.s18),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget listAlarm(MedicineAlarmCubit cubit) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 10,
    itemBuilder: (context, index) {
      return itemAlarm(cubit);
    },
  );
}

Widget itemPosts(
    {required context, required int index, required PostsCubit cubit}) {
  return Container(
    margin: const EdgeInsets.symmetric(
        horizontal: SizeManager.s16, vertical: SizeManager.s20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  showImage(context, AssetsManager.me);
                },
                child: profileImage(
                    image: CachedNetworkImageProvider(cubit.post[index]
                                ['userProfileImage'] !=
                            null
                        ? '$startPhoto${cubit.post[index]['userProfileImage']}'
                        : 'https://scontent-hbe1-1.xx.fbcdn.net/v/t39.30808-6/298097482_1446954539154955_1988367110792247724_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=geNfUqd8UeYAX_sWifO&_nc_ht=scontent-hbe1-1.xx&oh=00_AfCUgC7CITcSMmI2-qw4dFBS-jkDMScXIq3WgGdmFJocvg&oe=65D05541'),
                    height: SizeManager.s65,
                    width: SizeManager.s65,
                    radius: SizeManager.s35)),
            const SizedBox(
              width: SizeManager.s12,
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: SizeManager.s150,
                        child: Text(
                          cubit.post[index]['userName'] != null
                              ? cubit.post[index]['userName']
                              : '',
                          style: StylesManager.loginCreate,
                          overflow: TextOverflow.ellipsis,
                        )),
                    greenDone()
                  ],
                ),
                const SizedBox(
                  height: SizeManager.s4,
                ),
                SizedBox(
                    width: SizeManager.s150,
                    child: Text("Heart Sergeon",
                        style: StylesManager.or,
                        overflow: TextOverflow.ellipsis)),
              ],
            )
          ],
        ),
        const SizedBox(
          height: SizeManager.s20,
        ),
        Text(
          'The title of post:',
          style: StylesManager.itemHome.copyWith(fontSize: SizeManager.s20),
        ),
        const SizedBox(
          height: SizeManager.s10,
        ),
        ReadMoreText(
          cubit.post[index]['mainText'],
          style: StylesManager.itemHome.copyWith(fontSize: SizeManager.s16),
          trimLines: 2,
          colorClickableText: ColorManager.primaryColor,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          moreStyle: const TextStyle(
              color: ColorManager.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: SizeManager.s10,
        ),
        Container(
          height: SizeManager.s230,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(SizeManager.s24)),
          ),
          child: CachedNetworkImage(
              imageUrl: '$startPhoto${cubit.post[index]['images']}'),
        ),
        const SizedBox(
          height: SizeManager.s16,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: SizeManager.s12, right: SizeManager.s12),
          child: Row(
            children: [
              Text(
                '${cubit.post[index]['reactions']}',
                style: StylesManager.or,
              ),
              SizedBox(
                width: SizeManager.s6,
              ),
              const Icon(
                FontAwesomeIcons.heart,
                size: SizeManager.s16,
                color: Colors.red,
              ),
              Spacer(),
              Text(
                '${cubit.post[index]['commentsNumber']}  comments',
                style: StylesManager.or,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: SizeManager.s8,
        ),
        dividerBlue(
            width: double.infinity, color: ColorManager.backGrey, thickness: 3),
        const SizedBox(
          height: SizeManager.s16,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: SizeManager.s12, right: SizeManager.s12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  cubit.makeAndDeleteLike(cubit.post[index]['id'], 1,
                      cubit.post[index]['likedByUser']);
                },
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.thumbsUp,
                        size: SizeManager.s24,
                        color: cubit.post[index]['likedByUser'] == true
                            ? ColorManager.headOrange
                            : ColorManager.greyColor),
                    const SizedBox(
                      width: SizeManager.s4,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Text('like',
                            style: StylesManager.or.copyWith(
                                color: cubit.post[index]['likedByUser'] == true
                                    ? ColorManager.headOrange
                                    : ColorManager.greyColor,
                                fontSize: SizeManager.s16))),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.comment,
                        size: SizeManager.s24,
                        color: cubit.comment == true
                            ? ColorManager.headOrange
                            : ColorManager.greyColor),
                    const SizedBox(
                      width: SizeManager.s4,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Text('comment',
                            style: StylesManager.or.copyWith(
                                color: cubit.comment == true
                                    ? ColorManager.headOrange
                                    : ColorManager.greyColor,
                                fontSize: SizeManager.s16))),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget listPosts(context, PostsCubit cubit) {
  return AnimationLimiter(
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cubit.post.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
            position: 0,
            duration: const Duration(seconds: 1),
            child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                    child: itemPosts(
                        context: context, index: index, cubit: cubit))));
      },
    ),
  );
}

Widget textFieldAdd({
  required String hint,
  required TextEditingController textEditingController,
  required String validator,
}) {
  return TextFormField(
    controller: textEditingController,
    validator: (value) => value!.trim().isEmpty ? validator : null,
    style: StylesManager.itemHome.copyWith(fontSize: 20),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38),
      border: const UnderlineInputBorder(),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: SizeManager.s1, color: Colors.black54)),
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: SizeManager.s1, color: Colors.black54)),
      focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primaryColor)),
      errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.headOrange)),
    ),
  );
}

Widget dropFormAdd(
    {required String? selectedItem,
    required String validator,
    required List list,
    required void function(value),
    required double left,
    required double right,
    required double top,
    required double bottom,
    GlobalKey<FormFieldState>? key}) {
  return DropdownButtonFormField(
    key: key,
    validator: (value) => value == null ? validator : null,
    value: selectedItem,
    items: list.map((e) {
      return DropdownMenuItem(
        value: e,
        child: Text(e),
      );
    }).toList(),
    onChanged: (value) {
      function(value);
    },
    icon: const Icon(
      Icons.arrow_drop_down_outlined,
      color: ColorManager.headOrange,
    ),
    dropdownColor: const Color(0xffe6e3ee),
    decoration: const InputDecoration(
      hintText: 'category',
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: SizeManager.s1, color: Colors.black54)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: SizeManager.s1, color: Colors.black54)),
      focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primaryColor)),
      errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.headOrange)),
    ),
  );
}

Widget buildDatePicker(dateTime, function(value)) => SizedBox(
      height: 180,
      child: CupertinoDatePicker(
        initialDateTime: dateTime,
        maximumYear: DateTime.now().year,
        onDateTimeChanged: (value) => function(value),
        mode: CupertinoDatePickerMode.date,
      ),
    );

Future showSheet(context, Widget child, onClicked) {
  return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
            actions: [child],
            cancelButton: CupertinoActionSheetAction(
                child: Text('done'), onPressed: onClicked),
          ));
}

Widget textFieldEdit(
    {required String hint,
    required TextEditingController textEditingController,
    required String validator,
    required Widget Icon}) {
  return TextFormField(
    controller: textEditingController,
    validator: (value) => value!.trim().isEmpty ? validator : null,
    style: StylesManager.itemHome.copyWith(fontSize: 20),
    decoration: InputDecoration(
      prefixIcon: Icon,
      labelText: hint,
      labelStyle: const TextStyle(color: Colors.black87, fontSize: 18),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(width: SizeManager.s1, color: Colors.grey)),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(width: SizeManager.s1, color: Colors.grey)),
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(color: ColorManager.primaryColor)),
      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(color: ColorManager.headOrange)),

    ),
  );
}

AwesomeDialog showDialogAwsome(
    context, desc, DialogType dialogType, functionOk) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: dialogType,
    body: Center(
      child: Text(
        desc,
        style: StylesManager.headPrimary3
            .copyWith(fontStyle: FontStyle.italic, fontSize: SizeManager.s16),
      ),
    ),
    title: 'This is Ignored',
    desc: 'This is also Ignored',
    btnOkOnPress: functionOk,
  )..show();
}

AwesomeDialog askDialogAwsome(
    context, desc, DialogType dialogType, functionOk) {
  return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: dialogType,
      body: Center(
        child: Text(
          desc,
          style: StylesManager.headPrimary3
              .copyWith(fontStyle: FontStyle.italic, fontSize: SizeManager.s16),
        ),
      ),
      btnOkOnPress: functionOk,
      btnCancel: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(22))),
          child: Text('cancel',
              style: TextStyle(color: Colors.white, fontSize: SizeManager.s16),
              textAlign: TextAlign.center),
        ),
      ))
    ..show();
}

void showToast(String msg) async {
  await Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: ColorManager.primaryColor,
      fontSize: SizeManager.s18,
      textColor: Colors.white);
}

Widget listPatientPosts(context, PostsCubit cubit) {
  return AnimationLimiter(
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cubit.patientPost.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
            position: 0,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                    child: itemPatientPosts(
                        context: context, index: index, cubit: cubit))));
      },
    ),
  );
}

Widget itemPatientPosts(
    {required context, required int index, required PostsCubit cubit}) {
  String date = cubit.patientPost[index]['date'];
  DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
  return Container(
    margin: const EdgeInsets.symmetric(
        horizontal: SizeManager.s16, vertical: SizeManager.s20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  showImage(
                      context,
                      cubit.patientPost[index]['userProfileImage'] != null
                          ? '$startPhoto${cubit.patientPost[index]['userProfileImage']}'
                          : 'https://scontent-hbe1-2.xx.fbcdn.net/v/t39.30808-6/298097482_1446954539154955_1988367110792247724_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=geNfUqd8UeYAX9Qwg0r&_nc_ht=scontent-hbe1-2.xx&oh=00_AfDaWkKnVrufe4zf0Z29FOXYqOGRdQ48uK-RvHtWE3yXYw&oe=65D05541');
                },
                child: profileImage(
                    image: NetworkImage(cubit.patientPost[index]
                                ['userProfileImage'] !=
                            null
                        ? '$startPhoto${cubit.patientPost[index]['userProfileImage']}'
                        : 'https://scontent-hbe1-2.xx.fbcdn.net/v/t39.30808-6/298097482_1446954539154955_1988367110792247724_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=geNfUqd8UeYAX9Qwg0r&_nc_ht=scontent-hbe1-2.xx&oh=00_AfDaWkKnVrufe4zf0Z29FOXYqOGRdQ48uK-RvHtWE3yXYw&oe=65D05541'),
                    height: SizeManager.s65,
                    width: SizeManager.s65,
                    radius: SizeManager.s35)),
            const SizedBox(
              width: SizeManager.s12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: SizeManager.s150,
                          child: Text(
                            cubit.patientPost[index]['userName'] != null
                                ? cubit.patientPost[index]['userName']
                                : '',
                            style: StylesManager.loginCreate,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Spacer(),
                      popMenu(
                          cubit.menuePop(
                              context, cubit.patientPost[index]['id'], index),
                          const Icon(FontAwesomeIcons.ellipsisH))
                    ],
                  ),
                  Text(
                    DateFormat('MM/dd/yyyy   hh:mm a').format(parseDate),
                    style: StylesManager.or,
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: SizeManager.s20,
        ),
        Text(
          'The title of post:',
          style: StylesManager.itemHome.copyWith(fontSize: SizeManager.s20),
        ),
        const SizedBox(
          height: SizeManager.s10,
        ),
        ReadMoreText(
          cubit.patientPost[index]['mainText'],
          style: StylesManager.itemHome.copyWith(fontSize: SizeManager.s16),
          trimLines: 2,
          colorClickableText: ColorManager.primaryColor,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          moreStyle: const TextStyle(
              color: ColorManager.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: SizeManager.s10,
        ),
        Container(
          height: SizeManager.s230,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(SizeManager.s24)),
          ),
          child: Image.asset(AssetsManager.session, fit: BoxFit.fill),
        ),
        const SizedBox(
          height: SizeManager.s16,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: SizeManager.s12, right: SizeManager.s12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.thumbsUp,
                        size: SizeManager.s24,
                        color: cubit.like == true
                            ? ColorManager.headOrange
                            : ColorManager.greyColor),
                    const SizedBox(
                      width: SizeManager.s4,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Text('like',
                            style: StylesManager.or.copyWith(
                                color: cubit.like == true
                                    ? ColorManager.headOrange
                                    : ColorManager.greyColor,
                                fontSize: SizeManager.s16))),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.comment,
                        size: SizeManager.s24,
                        color: cubit.comment == true
                            ? ColorManager.headOrange
                            : ColorManager.greyColor),
                    const SizedBox(
                      width: SizeManager.s4,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Text('comment',
                            style: StylesManager.or.copyWith(
                                color: cubit.comment == true
                                    ? ColorManager.headOrange
                                    : ColorManager.greyColor,
                                fontSize: SizeManager.s16))),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget popMenu(List<PopupMenuEntry> list, widget) {
  return PopupMenuButton(
    color: Colors.white,
    itemBuilder: (context) => list,
    icon: widget,
  );
}

Widget dateField(TextEditingController date, TextStyle style,
    InputDecoration inputDecoration, function) {
  return TextFormField(
      controller: date,
      style: style,
      decoration: inputDecoration,
      readOnly: true,
      onTap: function);
}

Widget addBorderTop(function, String title) {
  return Container(
    width: double.infinity,
    height: 100,
    padding: EdgeInsets.symmetric(vertical: 30, horizontal: SizeManager.s16),
    decoration: const BoxDecoration(
        color: ColorManager.primaryColor,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(SizeManager.s22),
            bottomLeft: Radius.circular(SizeManager.s22))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title,
            style: StylesManager.registerCreate
                .copyWith(fontSize: SizeManager.s28)),
        IconButton(
            onPressed: function,
            icon: const Icon(
              Icons.check,
              color: Colors.white,
              size: SizeManager.s35,
            )),
      ],
    ),
  );
}

Widget listDoctorPosts(context, BlogCubit cubit) {
  return AnimationLimiter(
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cubit.doctorPosts.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
            position: 0,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                    child: itemDoctorPosts(
                        context: context, index: index, cubit: cubit))));
      },
    ),
  );
}

Widget itemDoctorPosts(
    {required context, required int index, required BlogCubit cubit}) {
  String date = cubit.doctorPosts[index]['date'];
  DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
  return Container(
    margin: const EdgeInsets.symmetric(
        horizontal: SizeManager.s16, vertical: SizeManager.s20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  showImage(
                      context,
                      cubit.doctorPosts[index]['doctorProfileImage'] != null
                          ? '$startPhoto${cubit.doctorPosts[index]['doctorProfileImage']}'
                          : 'https://scontent-hbe1-2.xx.fbcdn.net/v/t39.30808-6/298097482_1446954539154955_1988367110792247724_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=geNfUqd8UeYAX9Qwg0r&_nc_ht=scontent-hbe1-2.xx&oh=00_AfDaWkKnVrufe4zf0Z29FOXYqOGRdQ48uK-RvHtWE3yXYw&oe=65D05541');
                },
                child: profileImage(
                    image: NetworkImage(cubit.doctorPosts[index]
                                ['doctorProfileImage'] !=
                            null
                        ? '$startPhoto${cubit.doctorPosts[index]['doctorProfileImage']}'
                        : 'https://scontent-hbe1-2.xx.fbcdn.net/v/t39.30808-6/298097482_1446954539154955_1988367110792247724_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=geNfUqd8UeYAX9Qwg0r&_nc_ht=scontent-hbe1-2.xx&oh=00_AfDaWkKnVrufe4zf0Z29FOXYqOGRdQ48uK-RvHtWE3yXYw&oe=65D05541'),
                    height: SizeManager.s65,
                    width: SizeManager.s65,
                    radius: SizeManager.s35)),
            const SizedBox(
              width: SizeManager.s12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: SizeManager.s150,
                          child: Text(
                            cubit.doctorPosts[index]['doctorName'] != null
                                ? cubit.doctorPosts[index]['doctorName']
                                : '',
                            style: StylesManager.loginCreate,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Spacer(),
                      popMenu(
                          cubit.menuePop(
                              context, cubit.doctorPosts[index]['id'], index),
                          const Icon(FontAwesomeIcons.ellipsisH))
                    ],
                  ),
                  Text(
                    DateFormat('MM/dd/yyyy   hh:mm a').format(parseDate),
                    style: StylesManager.or,
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: SizeManager.s20,
        ),
        Text(
          'The title of post:',
          style: StylesManager.itemHome.copyWith(fontSize: SizeManager.s20),
        ),
        const SizedBox(
          height: SizeManager.s10,
        ),
        ReadMoreText(
          cubit.doctorPosts[index]['title'],
          style: StylesManager.itemHome.copyWith(fontSize: SizeManager.s16),
          trimLines: 2,
          colorClickableText: ColorManager.primaryColor,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          moreStyle: const TextStyle(
              color: ColorManager.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: SizeManager.s10,
        ),
        Container(
          height: SizeManager.s230,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(SizeManager.s24)),
          ),
          child: Image.network(
              '$baseUrl/file/${cubit.doctorPosts[index]['covorImage']}',
              fit: BoxFit.fill),
        ),
        const SizedBox(
          height: SizeManager.s16,
        ),
        // Padding(
        //   padding: const EdgeInsets.only(
        //       left: SizeManager.s12, right: SizeManager.s12),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       InkWell(
        //         onTap: () {},
        //         child: Row(
        //           children: [
        //             Icon(FontAwesomeIcons.thumbsUp,
        //                 size: SizeManager.s24,
        //                 color: cubit.like == true
        //                     ? ColorManager.headOrange
        //                     : ColorManager.greyColor),
        //             const SizedBox(
        //               width: SizeManager.s4,
        //             ),
        //             Container(
        //                 margin: const EdgeInsets.only(top: 5),
        //                 child: Text('like',
        //                     style: StylesManager.or.copyWith(
        //                         color: cubit.like == true
        //                             ? ColorManager.headOrange
        //                             : ColorManager.greyColor,
        //                         fontSize: SizeManager.s16))),
        //           ],
        //         ),
        //       ),
        //       const Spacer(),
        //       InkWell(
        //         onTap: () {},
        //         child: Row(
        //           children: [
        //             Icon(FontAwesomeIcons.comment,
        //                 size: SizeManager.s24,
        //                 color: cubit.comment == true
        //                     ? ColorManager.headOrange
        //                     : ColorManager.greyColor),
        //             const SizedBox(
        //               width: SizeManager.s4,
        //             ),
        //             Container(
        //                 margin: const EdgeInsets.only(top: 5),
        //                 child: Text('comment',
        //                     style: StylesManager.or.copyWith(
        //                         color: cubit.comment == true
        //                             ? ColorManager.headOrange
        //                             : ColorManager.greyColor,
        //                         fontSize: SizeManager.s16))),
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // )
      ],
    ),
  );
}

Widget likedComment(bool isLiked, int reaction, function) {
  return LikeButton(
    onTap: (isLiked) {
      // Perform your desired action here
      print('Button is liked: $isLiked');
      function();
      return Future.value(!isLiked); // Toggle like state
    },
    isLiked: isLiked,
    likeCount: reaction,
    bubblesColor: BubblesColor(
        dotPrimaryColor: Colors.green, dotSecondaryColor: Colors.greenAccent),
    circleColor:
        CircleColor(start: ColorManager.daysColor, end: ColorManager.daysColor),
    likeBuilder: (isLiked) {
      final Color color = isLiked ? Colors.red : Colors.grey;
      return Icon(
        Icons.favorite,
        color: color,
      );
    },
    countBuilder: (likeCount, isLiked, text) {
      final Color color = isLiked ? Colors.black : Colors.grey;
      return Text(
        text,
        style:
            TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20),
      );
    },
  );
}

Widget likedArticled(bool isLiked, int reaction, function) {
  return LikeButton(
    isLiked: isLiked,
    likeCount: reaction,
    bubblesColor: BubblesColor(
        dotPrimaryColor: Colors.green, dotSecondaryColor: Colors.greenAccent),
    circleColor:
        CircleColor(start: ColorManager.daysColor, end: ColorManager.daysColor),
    likeBuilder: (isLiked) {
      final Color color = isLiked ? Colors.red : Colors.grey;
      return Icon(
        Icons.favorite,
        color: color,
      );
    },
    countBuilder: (likeCount, isLiked, text) {
      final Color color = isLiked ? Colors.black : Colors.grey;

      return Text(
        text,
        style:
            TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20),
      );
    },
    onTap: (isLiked) {
      // Perform your desired action here
      print('Button is liked: $isLiked');
      function();
      return Future.value(!isLiked); // Toggle like state
    },
  );
}
