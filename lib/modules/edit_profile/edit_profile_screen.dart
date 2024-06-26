import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taafe/layout/home/home_cubit/home_cubit.dart';
import 'package:taafe/layout/home/home_cubit/home_state.dart';
import 'package:taafe/modules/edit_profile/edit_widgets/edit_widgets.dart';
import 'package:taafe/modules/setting_items/my_account/my_account_cubit/my_account_cubit.dart';
import 'package:taafe/modules/setting_items/my_account/my_account_cubit/my_account_state.dart';
import 'package:taafe/shared/network/remote/end_points.dart';
import 'package:taafe/shared/resourses/value_app.dart';

import '../../shared/components/components.dart';
import '../../shared/resourses/color_manager.dart';
import '../../shared/resourses/styles.dart';

class EditProfileScreen extends StatefulWidget {
String name;
String date;
String profileImage;
String title;
String description;


EditProfileScreen(this.name, this.date, this.profileImage, this.title, this.description);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController name;
  late TextEditingController date;
  late TextEditingController title;
  late TextEditingController description;
  late TextEditingController place;
  late TextEditingController startDate;
  late TextEditingController endDate;
  late TextEditingController tag;
  late TextEditingController price;
  late String profilePic;

  @override
  void initState() {
    name=TextEditingController();
    date=TextEditingController();
    title=TextEditingController();
    description=TextEditingController();

    name.text = widget.name;
    date.text = widget.date;
    profilePic=widget.profileImage;
    title.text = widget.title;
    description.text = widget.description;

    place = TextEditingController();
    startDate = TextEditingController();
    endDate = TextEditingController();
    tag = TextEditingController();
    price = TextEditingController();
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
                          BorderRadius.all(Radius.circular(SizeManager.s65)),
                      child: Image(
                          image: NetworkImage(
                              '$startPhoto${profilePic}'),
                          fit: BoxFit.cover),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            bottom: SizeManager.s20, right: SizeManager.s16),
                        child: Icon(Icons.edit)),
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
              textFieldEdit(
                  hint: 'title',
                  textEditingController: name,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter your title'),
              SizedBox(
                height: SizeManager.s40,
              ),
              dateEdit(date, 'date birth', () {
                cubit.showCalender(context: context, date: date);
              }),
              SizedBox(
                height: SizeManager.s40,
              ),
              textFieldEdit(
                  hint: 'description',
                  textEditingController: name,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter your description'),
              SizedBox(
                height: SizeManager.s40,
              ),
              dividerBlue(
                width: 200,
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              Text(
                'Educational Records :',
                style: StylesManager.itemHome
                    .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              textFieldEdit(
                  hint: 'place',
                  textEditingController: name,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter your description'),
              SizedBox(
                height: SizeManager.s40,
              ),
              Row(
                children: [
                  Expanded(
                    child: dateEdit(date, 'start Date', () {
                      cubit.showCalender(context: context, date: date);
                    }),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: dateEdit(date, 'end Date', () {
                      cubit.showCalender(context: context, date: date);
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              dividerBlue(
                width: 200,
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              Text(
                'experince Records :',
                style: StylesManager.itemHome
                    .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              textFieldEdit(
                  hint: 'place',
                  textEditingController: name,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter your description'),
              SizedBox(
                height: SizeManager.s40,
              ),
              Row(
                children: [
                  Expanded(
                    child: dateEdit(date, 'start Date', () {
                      cubit.showCalender(context: context, date: date);
                    }),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: dateEdit(date, 'end Date', () {
                      cubit.showCalender(context: context, date: date);
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              dividerBlue(
                width: 200,
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              Text(
                'certificate Records :',
                style: StylesManager.itemHome
                    .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              textFieldEdit(
                  hint: 'title',
                  textEditingController: name,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter your description'),
              SizedBox(
                height: SizeManager.s40,
              ),
              textFieldEdit(
                  hint: 'place',
                  textEditingController: name,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter your description'),
              SizedBox(
                height: SizeManager.s40,
              ),
              dateEdit(date, 'Date', () {
                cubit.showCalender(context: context, date: date);
              }),
              SizedBox(
                height: SizeManager.s40,
              ),
              dividerBlue(
                width: 200,
              ),
              SizedBox(
                height: SizeManager.s40,
              ),
              textFieldEdit(
                  hint: 'tags',
                  textEditingController: name,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter your description'),
              SizedBox(
                height: SizeManager.s40,
              ),
              textFieldEdit(
                  hint: 'price',
                  textEditingController: name,
                  Icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
                  validator: 'enter your description'),
              SizedBox(
                height: SizeManager.s40,
              ),
              ElevatedButton(
                onPressed: () {},
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
