
import 'package:flutter/material.dart';

double widthMedia({required context,required double x}){
  return MediaQuery.of(context).size.width*x;
}

double hightMedia({required context,required double h}){
  return MediaQuery.of(context).size.height*h;
}



