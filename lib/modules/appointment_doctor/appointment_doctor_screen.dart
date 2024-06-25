import 'package:flutter/material.dart';
import 'package:taafe/shared/components/components.dart';

import 'package:taafe/shared/resourses/color_manager.dart';

import 'package:taafe/shared/resourses/styles.dart';
import 'package:taafe/shared/resourses/value_app.dart';

class AppointmentDoctorScreen extends StatelessWidget {
  const AppointmentDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: ColorManager.primaryColor,
        iconTheme:const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: SizeManager.s200,
            padding:const EdgeInsets.only(left: SizeManager.s24,top:SizeManager.s20 ),
            decoration:const BoxDecoration(
              color: ColorManager.primaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(SizeManager.s30),bottomRight: Radius.circular(SizeManager.s30))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileImage(height: SizeManager.s120,width:  SizeManager.s120,radius:  SizeManager.s12),
                const SizedBox(width: SizeManager.s20,),
                Padding(
                  padding: const EdgeInsets.only(top: SizeManager.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dr.Vanadis Odindatter',style: StylesManager.registerCreate.copyWith(fontSize: SizeManager.s16),),
                      SizedBox(height: SizeManager.s14,),
                      SizedBox(
                          width: SizeManager.s150,
                          child: Text("Heart Sergeon",
                              style: StylesManager.or.copyWith(color: Colors.white,fontWeight: FontWeight.w300), overflow: TextOverflow.ellipsis)),
                      SizedBox(height: SizeManager.s14,),
                      starsYellow(2)
                    ],
                  ),
                )
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
