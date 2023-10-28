import 'package:awesome_icons/awesome_icons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../layout/home/home_cubit/home_cubit.dart';
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
          vertical: hightMedia(context: context, h: SizeManager.s_07)),
      child: Column(
        children: [
          Image(
            image: const AssetImage(AssetsManager.logo),
            width: widthMedia(context: context, x: SizeManager.s_7),
            height: hightMedia(context: context, h: SizeManager.s_2),
          ),
          Image(
            image: const AssetImage(AssetsManager.shadow),
            width: widthMedia(context: context, x: SizeManager.s_51),
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

Widget textFieldPrefix(
    {required TextInputType textInputType,
    required TextEditingController controller,
    required String label,
    required String validator,
    bool obsurce = false,
    Widget? icons}) {
  return TextFormField(
    controller: controller,
    validator: (value) => value!.isEmpty ? validator : null,
    obscureText: obsurce,
    keyboardType: textInputType,
    decoration: InputDecoration(
      prefixIcon: icons,
      labelText: label,
    ),
  );
}

Widget textFieldRegister(
    {required TextEditingController controller,
    required String validator,
    required String hint,
    bool obsurce = false,
    bool confirm = false,
    required TextInputType textInputType,
    Widget? suffixIcon,
    bool email = false}) {
  return TextFormField(
    validator: (value) {
      if (value!.isEmpty) {
        return validator;
      }
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(controller.text);
      if (email && !emailValid) {
        return StringManager.emailFormat;
      }
      return null;
    },
    controller: controller,
    style: StylesManager.hint,
    obscureText: obsurce,
    keyboardType: textInputType,
    cursorColor: ColorManager.textWhite,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      hintText: hint,
      hintStyle: StylesManager.hint,
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(SizeManager.s30)),
          borderSide: BorderSide(color: ColorManager.textWhite)),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(SizeManager.s30)),
          borderSide: BorderSide(color: ColorManager.textWhite)),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(SizeManager.s30)),
          borderSide: BorderSide(color: ColorManager.textWhite)),
    ),
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

Widget loginIcon() {
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
      loginWith(null, AssetsManager.gmail),
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

Widget createAccountText() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        StringManager.registerCreate,
        style: StylesManager.registerCreate,
      ),
      const SizedBox(
        width: SizeManager.s6,
      ),
      Text(
        StringManager.registerAccount,
        style: StylesManager.registerAccount,
      )
    ],
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

Widget searchKind(context, function, String hint,{double left=SizeManager.s24,double right=SizeManager.s22}) {
  return Padding(
    padding:
         EdgeInsets.only(left:left , right:right ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeManager.s55,
          child: TextFormField(
            style: StylesManager.label,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: function, child: const Icon(Icons.search_outlined)),
              fillColor: ColorManager.search,
              filled: true,
              hintText: hint,
              hintStyle: const TextStyle(color: ColorManager.primaryColor),
              focusedBorder: const OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(SizeManager.s30)),
                  borderSide: BorderSide(color: ColorManager.search)),
              enabledBorder: const OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(SizeManager.s30)),
                  borderSide: BorderSide(color: ColorManager.search)),
            ),
          ),
        )
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

Widget appBarAction(String name, String assets, function) {
  return Row(
    children: [
      Text(name, style: StylesManager.hi),
      const SizedBox(
        width: SizeManager.s10,
      ),
      SizedBox(
        height: SizeManager.s24,
        width: SizeManager.s24,
        child: InkWell(
          onTap: function,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: Image(fit: BoxFit.cover, image: AssetImage(assets)),
          ),
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
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s24)),
        border: Border.all(color: ColorManager.primaryColor, width: .7)),
    width: 110,
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
          height: SizeManager.s135,
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

Widget titleRow(context, String title, function, String sort) {
  return Row(
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      const Spacer(),
      InkWell(
        onTap: function,
        child: Container(
          margin: const EdgeInsets.only(top: SizeManager.s2),
          padding: const EdgeInsets.all(SizeManager.s6),
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(SizeManager.s14)),
            border: Border.all(color: ColorManager.primaryColor, width: 1),
          ),
          child: Row(
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
      )
    ],
  );
}

Widget greenContainer(String text, function) {
  return InkWell(
    onTap: function,
    child: Container(
      padding: const EdgeInsets.all(SizeManager.s6),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(SizeManager.s22)),
        color: Colors.green,
      ),
      child: Text(
        text,
        style: StylesManager.greenContainer,
      ),
    ),
  );
}

Widget profileImage(double height, double width, double radius) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: ColorManager.primaryColor, width: 1),
        image: const DecorationImage(
            image: AssetImage(AssetsManager.me), fit: BoxFit.cover)),
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

Widget starsYellow() {
  return SmoothStarRating(
      allowHalfRating: true,
      halfFilledIconData: Icons.star_half,
      starCount: 5,
      rating: 3.3,
      size: 20.0,
      filledIconData: Icons.star,
      color: Colors.orange,
      borderColor: Colors.grey,
      spacing: 0.0);
}

Widget itemTherapists(context) {
  return Container(
    margin: const EdgeInsets.all(SizeManager.s14),
    child: Column(
      children: [
        profileImage(SizeManager.s135, SizeManager.s135, SizeManager.s84),
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
                    style: StylesManager.or, overflow: TextOverflow.ellipsis)),
            starsYellow(),
            const SizedBox(
              height: SizeManager.s12,
            ),
            Text(
              StringManager.about,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
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
            greenContainer(StringManager.appointment, null)
          ],
        )
      ],
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
        titleRow(context, StringManager.therapists, null, StringManager.sort),
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
    double left = SizeManager.s0,
    double top = SizeManager.s0,
    double width = SizeManager.s58,
    required double radius,
    required String text}) {
  return InkWell(
    onTap: function,
    child: Container(
      padding: const EdgeInsets.only(top: SizeManager.s5),
      margin: EdgeInsets.only(left: left, top: top),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        color: ColorManager.primaryColor,
      ),
      width: width,
      height: SizeManager.s20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: StylesManager.greenContainer
                .copyWith(fontSize: SizeManager.s10),
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
        titleRow(context, StringManager.blogs, null, StringManager.sort),
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
    height: SizeManager.s250,
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
            profileImage(SizeManager.s75, SizeManager.s75, SizeManager.s55),
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
                starsYellow(),
                const SizedBox(
                  height: SizeManager.s2,
                ),
                Text(
                  '4.78 (1,354 reviews)',
                  style: StylesManager.or.copyWith(fontSize: SizeManager.s11),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.user,
                  size: SizeManager.s14,
                ),
                Text(
                  '+1000 sessions',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: SizeManager.s10, fontWeight: FontWeight.w600),
                )
              ],
            )
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
                  width: SizeManager.s2,
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
                  width: SizeManager.s14,
                ),
                Text(
                  '50 USD / 60 min',
                  style: StylesManager.itemHome
                      .copyWith(fontSize: SizeManager.s10),
                ),
                const SizedBox(
                  width: SizeManager.s55,
                ),
                greenContainer(StringManager.appointment, () {})
              ],
            )
          ],
        )
      ],
    ),
  );
}

Widget listViewBlogsV(context) {
  return Expanded(
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return itemBlogsV(context);
      },
    ),
  );
}

Widget itemBlogsV(context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
    margin: const EdgeInsets.all(SizeManager.s14),
    height: SizeManager.s260,
    width: SizeManager.s84,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(SizeManager.s30)),
        color: Colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetsManager.session), fit: BoxFit.fill),
            borderRadius: BorderRadius.all(
              Radius.circular(SizeManager.s30),
            ),
          ),
        ),
        const SizedBox(height: SizeManager.s3),
        Text(
          'Depression solutions',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.orange,
              fontWeight: FontWeight.w600,
              fontSize: SizeManager.s18),
        ),
        const SizedBox(height: SizeManager.s3),
        SizedBox(
          height: 25,
          child: Text(
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam Lorem ipsum dolor sit amet, consectetur adipisicing Lorem ipsum dolor sit amet,   ',
              style: StylesManager.itemHome.copyWith(fontSize:SizeManager.s10),maxLines: 2,overflow: TextOverflow.ellipsis),
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
  );
}

Widget itemCommunity(function,IconData icon,String text){
  return InkWell(
    onTap: function,
    child: Container(
      height: SizeManager.s150,
      width: SizeManager.s135,
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.primaryColor,width: SizeManager.s_7),
        borderRadius:const BorderRadius.all(Radius.circular(SizeManager.s22)),
      ),
      child: Column(
        children: [
          const SizedBox(height: SizeManager.s20,),
          Icon(icon ,color: ColorManager.greenColor,size: SizeManager.s40,),
          const SizedBox(height: SizeManager.s18,),
          Text(text,style: StylesManager.itemHome,maxLines: 3,textAlign: TextAlign.center,)
        ],
      ),

    ),
  );
}

Widget rowCommunity(item1,item2){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      item1,
      item2
    ],
  );
}

Widget floatingButton(function,Widget widget,{double width=SizeManager.s40,double height=SizeManager.s40}){
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

Widget quetsionDesigen(String content){
  return Container(
    padding: const EdgeInsets.all(SizeManager.s8),
    decoration:const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(SizeManager.s16)),
        color: ColorManager.backGrey
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringManager.q,style: StylesManager.bodySmall.copyWith(fontSize: SizeManager.s20),),
        Text(content,style: StylesManager.headPrimary3,),
      ],
    ),
  );
}

Widget asnwerDesigen(String content){
  return Container(
    padding: const EdgeInsets.all(SizeManager.s8),
    decoration:const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(SizeManager.s16)),
        color: ColorManager.backGrey
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringManager.a,style:StylesManager.bodySmall.copyWith(fontSize: SizeManager.s20),),
        Text(content,style: StylesManager.loginCreate),
      ],
    ),
  );
}


Widget qADesign(String quetion,String answer,String answerBy,String job){
  return Container(
    padding: const EdgeInsets.all(SizeManager.s8),
    margin:const EdgeInsets.all(SizeManager.s8),
    decoration: BoxDecoration(
      border: Border.all(color: ColorManager.headOrange,width: SizeManager.s_7),
      borderRadius:const BorderRadius.all(Radius.circular(SizeManager.s10))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(StringManager.category,style: StylesManager.category,),
            const SizedBox(width: SizeManager.s2,),
            Text('Depression Disorders',style: StylesManager.category,)
          ],
        ),
        const SizedBox(height: SizeManager.s6,),
        quetsionDesigen(quetion),
        const SizedBox(height: SizeManager.s10,),
        asnwerDesigen(answer),
        const SizedBox(height: SizeManager.s4,),
        Row(
          children: [
            const Text(StringManager.answer,style: TextStyle(color: ColorManager.greenColor,fontSize: SizeManager.s10),),
            const SizedBox(width: SizeManager.s8,),
            const Icon(Icons.account_circle,size: SizeManager.s16,color: ColorManager.headOrange,),
            const SizedBox(width: SizeManager.s4,),
            Text(answerBy,style:const TextStyle(color: ColorManager.greenColor,fontSize: SizeManager.s14),),
          ],
        ),
        Container(
          width: SizeManager.s150,
          color: ColorManager.primaryColor,
          height: SizeManager.s1,
        ),
        const SizedBox(height: SizeManager.s2,),
        Text(job,style:const TextStyle(fontSize: SizeManager.s10,color: ColorManager.primaryColor),)

      ],
    ),
  );
}

Widget listViewQAV(String quetion,String answer,String answerBy,String job) {
  return Expanded(
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return qADesign(quetion,answer,answerBy,job);
      },
    ),
  );
}

Widget testLogoScreen(context,function){
  return Column(
    children: [

      SizedBox(height: hightMedia(context: context, h: SizeManager.s_07),),
      const AspectRatio(aspectRatio: 16/9,child: Image(image: AssetImage(AssetsManager.testLogo))),
      SizedBox(height: hightMedia(context: context, h: SizeManager.s_1),),
      InkWell(onTap: function,child:const SizedBox(height: SizeManager.s250,width:SizeManager.s250,child: Image(image: AssetImage(AssetsManager.testStart))))
    ],
  );
}

Widget itemDrawer(context,icon,title,function){
  return InkWell(
    onTap: function,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon,color: ColorManager.headOrange,size: SizeManager.s20,),
            const SizedBox(width: SizeManager.s16,),
            Text(title,style: StylesManager.headPrimary3.copyWith(fontWeight: FontWeight.w500),),
            const Spacer(),
            const Icon(Icons.navigate_next,color: ColorManager.headOrange,size: SizeManager.s24,),
          ],
        ),
        const SizedBox(height:SizeManager.s4 ,),
        dividerBlue(width: widthMedia(context: context, x:SizeManager.s_51 )),
        const SizedBox(
          height: SizeManager.s28,
        )
      ],
    ),
  );
}

Widget dividerBlue({required double width,Color color=ColorManager.primaryColor}){
  return SizedBox(
    width: width,
    child: Divider(
      color: color,
      height: 4,
      thickness: 1,
    ),
  );
}

Widget medicalRecordItem({context,required IconData icon,required String title,required String value}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon,
              color: ColorManager.headOrange),
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
                Text(value,
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
          dividerBlue(width: widthMedia(context: context, x: SizeManager.s_4),color: ColorManager.greenColor),
          const SizedBox(height: SizeManager.s20,),
        ],
      )
    ],
  );
}

Widget itemSetting(context,icon,title,function){
  return InkWell(
    onTap: function,
    child: Padding(
      padding: const EdgeInsets.only(left: SizeManager.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon,color: ColorManager.headOrange,size: SizeManager.s20,),
              const SizedBox(width: SizeManager.s16,),
              Text(title,style: StylesManager.headPrimary3.copyWith(fontWeight: FontWeight.w500),),
              const Spacer(),
              const Icon(Icons.navigate_next,color: ColorManager.headOrange,size: SizeManager.s24,),
            ],
          ),
          const SizedBox(height:SizeManager.s4 ,),
          dividerBlue(width: widthMedia(context: context, x:SizeManager.s_7)),
           SizedBox(
            height: hightMedia(context: context, h: SizeManager.s_07),
          )
        ],
      ),
    ),
  );
}
