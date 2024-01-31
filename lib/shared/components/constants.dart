
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:taafe/layout/home/home_screen.dart';

import '../../modules/show_picture/show_picture_screen.dart';

double widthMedia({required context,required double x}){
  return MediaQuery.of(context).size.width*x;
}

double hightMedia({required context,required double h}){
  return MediaQuery.of(context).size.height*h;
}

void moveScreen({required context,required dynamic screen}) {
  Navigator.of(context).push(PageTransition(
      duration: const Duration(milliseconds: 600),
      type: PageTransitionType.rightToLeft,
      child:screen));
}

void showImage(context,image){
  Navigator.push(context, MaterialPageRoute(builder:(context) => ShowPicture(image:image)));
}




