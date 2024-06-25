import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_state.dart';

import 'package:taafe/shared/components/components.dart';

import 'package:taafe/shared/resourses/styles.dart';
import 'package:taafe/shared/resourses/value_app.dart';

class AddPostBlogScreen extends StatefulWidget {

  int whichScreen;

  AddPostBlogScreen(this.whichScreen,this.idPost, {super.key});

  int idPost;

  @override
  State<AddPostBlogScreen> createState() => _AddPostBlogScreenState(whichScreen,idPost);
}

class _AddPostBlogScreenState extends State<AddPostBlogScreen> {
  late TextEditingController title;
  late TextEditingController mainText;
  late TextEditingController tags;
  late GlobalKey<FormState> key;
  int which;
  int idPost;

  _AddPostBlogScreenState(this.which,this.idPost);

  @override
  void initState() {
    title = TextEditingController();
    mainText = TextEditingController();
    tags = TextEditingController();
    key = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlogCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<BlogCubit, BlogState>(
          listener: (context, state) {},
          builder: (context, state) =>
              Form(
                key: key,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      addBorderTop((){
                        cubit.checkValidationPost(
                          context: context,
                          key: key,
                          title: title,
                          mainText:mainText,
                          articleID:idPost,
                          which: which
                      );},'Add New Post'),
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
                                hint: 'Add mainText',
                                textEditingController: mainText,
                                validator: 'enter the description'),
                            const SizedBox(
                              height: SizeManager.s14,
                            ),
                            dropFormAdd(
                                validator: 'enter the category',
                                selectedItem: cubit.selectedCategory,
                                list:cubit.menuCategory,
                                function: (value) =>
                                    cubit.showResult(value, cubit.selectedCategory,cubit.category),
                                left: SizeManager.s10,
                                right: SizeManager.s10,
                                top: SizeManager.s10,
                                bottom: SizeManager.s10),
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

                                InkWell(onTap: () {cubit.pickImage(context);},
                                    child:const Icon(Icons.camera_alt_outlined)),

                              ],
                            ),
                            const SizedBox(
                              height: SizeManager.s28,
                            ),
                          ],
                        ),
                      ),
                      cubit.pickedImage == null
                          ? Text('No image selected.')
                          : Image.file(File(cubit.pickedImage!.path),width: 200,height: 200),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
