import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/blogs_cubit/blog_cubit.dart';

import '../../modules/show_picture/show_picture_screen.dart';
import '../network/remote/dio_helper.dart';
import '../network/remote/end_points.dart';
import '../resourses/color_manager.dart';
import '../resourses/value_app.dart';

double widthMedia({required context, required double x}) {
  return MediaQuery
      .of(context)
      .size
      .width * x;
}

double hightMedia({required context, required double h}) {
  return MediaQuery
      .of(context)
      .size
      .height * h;
}

void moveScreen({required context, required dynamic screen}) {
  Navigator.of(context).push(PageTransition(
      duration: const Duration(milliseconds: 600),
      type: PageTransitionType.rightToLeft,
      child: screen));
}

void showImage(context, image) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ShowPicture(image: image)));
}

Future<void> uploadImage(File file,context) async {
  FormData formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(file.path, filename:file.path.split(Platform.pathSeparator).last),
    // Add any other fields you need to send along with the image
  });
  DioHelper.postData(
    url: uploadProfile,
    data: formData,
    options: Options(
      headers: {
        "contentType": 'multipart/form-data',
      }, // Ensure the content type is set to multipart/form-data
    ),
  ).then((value) {
    print(value.data);
    BlogCubit.get(context).setImage(value.data);
    print('uuuuuuuuuuuu : ${BlogCubit.get(context).imageCoverBack}');
  }).catchError((Error) {
    print(Error.toString());
  });
}

Widget loadingProgress() {
  return Center(
      child: LoadingAnimationWidget.discreteCircle(
          color: ColorManager.primaryColor,
          size: SizeManager.s30));
}
