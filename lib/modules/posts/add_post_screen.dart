import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/navigation_bar_items/communities/communites_cubit/community_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/communities/communites_cubit/community_state.dart';
import 'package:taafe/modules/posts/posts_cubit/posts_cubit.dart';
import 'package:taafe/modules/posts/posts_cubit/posts_state.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';
import 'package:taafe/shared/resourses/value_app.dart';

class AddPostScreen extends StatefulWidget {

  int whichScreen;

  AddPostScreen(this.whichScreen,this.idPost, {super.key});

  int idPost;

  @override
  State<AddPostScreen> createState() => _AddPostScreenState(whichScreen,idPost);
}

class _AddPostScreenState extends State<AddPostScreen> {
  late TextEditingController title;
  late TextEditingController desvription;
  late TextEditingController tags;
  late GlobalKey<FormState> key;
  int which;
  int idPost;

  _AddPostScreenState(this.which,this.idPost);

  @override
  void initState() {
    title = TextEditingController();
    desvription = TextEditingController();
    tags = TextEditingController();
    key = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = PostsCubit.get(context);
    var cubitCommunity = CommunityCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<PostsCubit, PostsState>(
          listener: (context, state) {},
          builder: (context, state) =>
              Form(
                key: key,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: hightMedia(context: context, h: SizeManager.s_1),
                        padding:EdgeInsets.symmetric(horizontal: SizeManager.s16) ,
                        decoration: const BoxDecoration(
                            color: ColorManager.primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(SizeManager.s22),
                                bottomLeft: Radius.circular(SizeManager.s22))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Add New Post',
                                style: StylesManager.registerAccount
                                    .copyWith(fontSize: SizeManager.s28)),
                            IconButton(
                                onPressed: () {
                                  cubit.checkValidation(
                                      context: context,
                                      key: key,
                                      title: title,
                                      desvription: desvription,
                                      tags: tags,
                                      idPost: idPost,
                                      which: which
                                  );
                                },
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: SizeManager.s35,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: SizeManager.s22,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: SizeManager.s30, right: SizeManager.s28),
                        child: Column(
                          children: [
                            textFieldAdd(
                                hint: 'Add title',
                                textEditingController: title,
                                validator: 'enter the title'),
                            const SizedBox(
                              height: SizeManager.s14,
                            ),
                            textFieldAdd(
                                hint: 'Add description',
                                textEditingController: desvription,
                                validator: 'enter the description'),
                            const SizedBox(
                              height: SizeManager.s14,
                            ),
                            BlocConsumer<CommunityCubit,CommunityState>(
                              listener: (context, state) {},
                              builder:(context, state) => dropFormAdd(
                                  validator: 'enter the category',
                                  selectedItem: cubit.category,
                                  list:cubitCommunity.name,
                                  function: (value) =>
                                      cubit.showResult(value, cubit.category,cubitCommunity.community),
                                  left: SizeManager.s10,
                                  right: SizeManager.s10,
                                  top: SizeManager.s10,
                                  bottom: SizeManager.s10),
                            ),
                            const SizedBox(
                              height: SizeManager.s14,
                            ),
                            textFieldAdd(
                                hint: 'Tags',
                                textEditingController: tags,
                                validator: 'enter the Tags'),
                            const SizedBox(
                              height: SizeManager.s24,
                            ),
                  
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Add:', style: StylesManager.or,),
                                const SizedBox(
                                  width: SizeManager.s4,
                                ),
                                InkWell(onTap: () {},
                                    child: const Icon(Icons.video_call_outlined)),
                                const SizedBox(
                                  width: SizeManager.s4,
                                ),
                                InkWell(onTap: () {}, child:const Icon(Icons.upload)),
                                const SizedBox(
                                  width: SizeManager.s4,
                                ),
                  
                                InkWell(onTap: () {},
                                    child:const Icon(Icons.camera_alt_outlined)),
                  
                              ],
                            ),
                            const SizedBox(
                              height: SizeManager.s28,
                            ),
                          ],
                        ),
                      ),
                      const Text('Choose post type'),
                      const SizedBox(
                        height: SizeManager.s22,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(title: Text('Your name',style: StylesManager.or.copyWith(fontSize: 14)),
                              activeColor: ColorManager.headOrange,
                              value: PostsCubit.type[0],
                              groupValue: cubit.currentType,
                              onChanged: (value) => cubit.radioFunction(value),),
                          ),
                  
                          Expanded(
                            child: RadioListTile(
                              activeColor: ColorManager.headOrange,
                              title: Text('Anonymous member',style: StylesManager.or.copyWith(fontSize: 14)),
                              value: PostsCubit.type[1],
                              groupValue: cubit.currentType,
                              onChanged: (value) => cubit.radioFunction(value),),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
