import 'dart:io';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:taafe/layout/home/home_cubit/home_cubit.dart';
import 'package:taafe/layout/home/home_cubit/home_state.dart';
import 'package:taafe/modules/edit_profile/edit_widgets/edit_widgets.dart';

import 'package:taafe/shared/network/remote/end_points.dart';
import 'package:taafe/shared/resourses/value_app.dart';

import '../../shared/components/components.dart';
import '../../shared/resourses/color_manager.dart';
import '../../shared/resourses/styles.dart';

class EditProfileScreen extends StatefulWidget {
String name;
String dateServer;
String profileImage;
String language;


EditProfileScreen(this.name, this.dateServer, this.profileImage, this.language);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController name;
  late TextEditingController date;
  late String language;
  late String profilePic;

  @override
  void initState() {
    name=TextEditingController();
    date=TextEditingController();
    String dateFormat= DateFormat('MM-dd-yyyy').format(DateTime.parse(widget.dateServer));
    name.text = widget.name;
    date.text = dateFormat;
    profilePic=widget.profileImage;
    language= widget.language;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return ListView(
            padding: EdgeInsets.symmetric(
                horizontal: SizeManager.s20, vertical: SizeManager.s16),
            children: [
              Text(
                'Edit Profile',
              ),
              SizedBox(
                height: SizeManager.s20,
              ),
              CircleAvatar(
                radius: SizeManager.s65,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(SizeManager.s75)),
                      child:cubit.pickedImageProfile==null? Image(
                          image: NetworkImage(
                              '$startPhoto${profilePic}'),
                          fit: BoxFit.cover):Image.file(File(cubit.pickedImageProfile!.path),fit: BoxFit.cover,)
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            bottom: SizeManager.s20, right: SizeManager.s16),
                        child: InkWell(onTap: () {
                          cubit.pickImageProfile(context);
                        },child: Icon(Icons.edit))),
                  ],
                ),
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              textFieldEdit(
                  hint: 'name',
                  textEditingController: name,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter your name'),
              SizedBox(
                height: SizeManager.s40,
              ),
              dateEdit(date, 'date birth', () {
                cubit.showCalender(context: context, date: date);
              }),
              SizedBox(
                height: SizeManager.s40,
              ),
              ExpansionTile(title: Text('language',style: StylesManager.itemHome.copyWith(fontSize: 18),),iconColor: ColorManager.primaryColor,
              tilePadding: EdgeInsets.all(SizeManager.s4),
              childrenPadding: EdgeInsets.symmetric(horizontal: 5),
              children: [
                InkWell(
                  onTap: () {
                   cubit.changeLanguage(language, 'en');
                  },
                  child: Row(
                    children: [
                      Text('En',style: StylesManager.itemHome.copyWith(fontSize: 18),),
                      Spacer(),
                     language=='en'?Icon(Icons.done_outlined,color: ColorManager.primaryColor,):Text('')
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    cubit.changeLanguage(language, 'ar');
                  },
                  child: Row(
                    children: [
                      Text('Ar',style: StylesManager.itemHome.copyWith(fontSize: 18),),
                      Spacer(),
                      language=='ar'?Icon(Icons.done_outlined,color: ColorManager.primaryColor,):Text('')
                    ],
                  ),
                ),
              ],
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              ElevatedButton(
                onPressed: () {
                   cubit.editPatientName(name.text);
                   cubit.editPatientBirthDate(date.text);
                   //cubit.editPatientProfileImage();
                   cubit.editPatientLanguage(language);
                },
                child: Text('Create Account',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeManager.s12)), // <-- Radius
                  ),
                  backgroundColor: ColorManager.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: SizeManager.s16),
                ),
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
            ],
          );
        },
      ),
    );
  }
}
