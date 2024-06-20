import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_state.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/resourses/color_manager.dart';
import '../../../../shared/resourses/value_app.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  late TextEditingController categoryName;
  late TextEditingController description;
  late GlobalKey<FormState> key;

  @override
  void initState() {
    categoryName = TextEditingController();
    description = TextEditingController();
    key = GlobalKey();
    super.initState();
  }
  @override
  void dispose() {
    categoryName.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<BlogCubit, BlogState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = BlogCubit.get(context);
              return Form(
                  key: key,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      addBorderTop(() {
                        cubit.checkValidation(
                            key: key,
                            categoryName: categoryName,
                            description: description);
                      }, 'Add New Post'),
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
                                textEditingController: categoryName,
                                validator: 'enter the title'),
                            const SizedBox(
                              height: SizeManager.s14,
                            ),
                            textFieldAdd(
                                hint: 'Add description',
                                textEditingController: description,
                                validator: 'enter the description'),
                            const SizedBox(
                              height: 40,
                            ),
                            Align(alignment: Alignment.center,child: ElevatedButton(onPressed: (){   cubit.checkValidation(
                                key: key,
                                categoryName: categoryName,
                                description: description);}, child:const Text('add category',style: TextStyle(fontSize: SizeManager.s18,color: ColorManager.textWhite),))),
                          ],
                        ),
                      ),
                    ]),
                  ));
            }));
  }
}
