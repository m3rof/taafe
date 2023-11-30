import 'package:flutter/material.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/color_manager.dart';

import 'package:taafe/shared/resourses/value_app.dart';

import '../../shared/components/components.dart';

class AboutDoctorScreen extends StatelessWidget {
  const AboutDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:Container(
              decoration:const BoxDecoration(
                color: ColorManager.primaryColor,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeManager.s250,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        const SizedBox(height: SizeManager.s200,child: Image(image: AssetImage(AssetsManager.bubble))),
                        Positioned(
                          top: hightMedia(context: context, h: SizeManager.s_1),
                          child: GestureDetector(
                            onTap: (){
                              showImage(context,AssetsManager.me);
                            },
                            child: CircleAvatar(
                              radius: hightMedia(context: context, h: SizeManager.s_1),
                              backgroundColor: Colors.grey.shade700,
                              backgroundImage:const AssetImage(AssetsManager.me),
                            ),
                          ),
                        )
                        // Container(
                        //   height: ,
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ) ,
          ),
          SliverToBoxAdapter(child: aboutDoctor(context))
        ],
      )
        
          
          
        
      
    );
  }
}
