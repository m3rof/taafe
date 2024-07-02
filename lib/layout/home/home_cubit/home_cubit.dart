import 'dart:io';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:taafe/models/user_model/user_model.dart';
import 'package:taafe/modules/posts/patient_posts_screen.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/network/remote/dio_helper.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import '../../../models/doctor_models/doctor_main_model.dart';
import '../../../models/patient_model/patient_info_model.dart';
import '../../../models/patient_model/patient_main_info_model.dart';

import '../../../modules/navigation_bar_items/blogs/widget/category_screen.dart';
import '../../../modules/navigation_bar_items/communities/communities_screen.dart';
import '../../../modules/navigation_bar_items/q_a/q_a_screen.dart';
import '../../../modules/navigation_bar_items/test/test_screen.dart';
import '../../../modules/navigation_bar_items/therapists/therapists_screen.dart';
import '../../../modules/patient/edit_profile/edit_profile_screen.dart';
import '../../../modules/patient/medical_record/mediacal_record_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/remote/end_points.dart';
import '../home_widget/home_body.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<ItemServices> listServices = [
    ItemServices(AssetsManager.therapists, StringManager.therapists),
    ItemServices(AssetsManager.medical, StringManager.medical),
    ItemServices(AssetsManager.blogs, StringManager.blogs),
    ItemServices(AssetsManager.community, StringManager.community),
    ItemServices(AssetsManager.qA, StringManager.qA),
    ItemServices(AssetsManager.tests, StringManager.tests),
  ];

  List<ItemTest> listTest = [
    ItemTest(AssetsManager.worry, () {}),
    ItemTest(AssetsManager.anxiety, () {}),
    ItemTest(AssetsManager.deperession, () {}),
    ItemTest(AssetsManager.adiction, () {}),
    ItemTest(AssetsManager.parent, () {}),
    ItemTest(AssetsManager.arizona, () {}),
  ];

  List<Widget> listPage = [
    const HomeBody(),
    const TherapistsScreen(),
    const CategoryBlogScreen(),
    const CommunitiesScreen(),
    const QAScreen(),
    const TestScreen()
  ];

  List<Widget> listIcons = [
    const Icon(Icons.home),
    const Icon(FontAwesomeIcons.user),
    const Icon(Icons.message_outlined),
    const Icon(FontAwesomeIcons.users),
    const Icon(FontAwesomeIcons.comments),
    const Icon(FontAwesomeIcons.solidFile),
  ];

  int numPage = 0;

  void changePage(int index) {
    numPage = index;
    emit(ChangePagesState());
  }

  List<PopupMenuEntry> popMenueItems(context) {
    return [
      PopupMenuItem(
          child: ListTile(
        onTap: () {
          moveScreen(
              context: context,
              screen: EditProfileScreen(
                pateintMainModel!.name,
                pateintMainModel!.birthDate,
                pateintMainModel!.profileImage,
                pateintMainModel!.language,
              ));
        },
        leading: Icon(FontAwesomeIcons.edit),
        title: Text('Edit Profile'),
      )),
      PopupMenuItem(
          child: ListTile(
        onTap: () {
          moveScreen(context: context, screen: PatientPosts());
        },
        leading: Icon(FontAwesomeIcons.edit),
        title: Text('My posts'),
      )),
      PopupMenuItem(
          child: ListTile(
        onTap: () {
          moveScreen(
              context: context,
              screen: MedicalRecordScreen(pateintMainModel: pateintMainModel!));
        },
        leading: const Icon(Icons.medical_information),
        title: const Text(StringManager.medicalRecord),
      )),
      const PopupMenuDivider(),
      PopupMenuItem(
          child: ListTile(
        onTap: deleteAccount,
        title: Text('delete Account'),
      )),
      PopupMenuItem(
          child: ListTile(
        onTap: () {},
        title: Text('Logout'),
      )),
    ];
  }


  final _db=FirebaseFirestore.instance;

  void getUserDetails() async {
    final snapshot=await _db.collection('users').doc(uId).get();
    userData= UserData.fromJson(snapshot.data());
  }

  void deleteAccount()async{
    try{
      Response response=await DioHelper.deleteData(
        url: patientAccount,
        data: {'email': userData!.email},
      );
      print(response.data);
      emit(DeleteAccountSuccessState());
    }catch(error){
      print(error.toString());
      emit(DeleteAccountErrorState(error.toString()));
    }
  }


  PateintMainModel? pateintMainModel;

  void getPatientMain() async {
    try{
      Response response=await DioHelper.getData(url: patientMainInfo, query: {'patientID': uId});
      pateintMainModel = PateintMainModel.fromJson(response.data);
      print(response.data);
      emit(GetPatientMainSuccessState());
    }catch (error){
      print(error.toString());
      emit(GetPatientMainErrorState());
    }
  }

  PatientInfoModel? patientInfoModel;

  void getPatientInfo() async{
    try{
      Response response=await DioHelper.getData(url: patientInfo, query: {'patientID': uId});
      patientInfoModel = PatientInfoModel.fromJson(response.data);
      emit(GetPatientInfoSuccessState());
    }catch(error){
      print(error.toString());
      emit(GetPatientInfoErrorState());
    }
  }

  DateTime dateTime = DateTime.now();

  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: dateTime,
          maximumYear: DateTime.now().year,
          onDateTimeChanged: (value) => resultDateTime(value: value),
          mode: CupertinoDatePickerMode.date,
        ),
      );

  void resultDateTime({required value}) {
    dateTime = value;
    emit(HomePickDateState());
  }

  void showCalender({required context, required TextEditingController date}) {
    showSheet(context, buildDatePicker(), () {
      print(DateFormat('MM/dd/yyyy').format(dateTime));
      Navigator.pop(context);
      if (dateTime != null) {
        date.text = DateFormat('MM/dd/yyyy').format(dateTime);
      }
    });
    emit(HomeShowDateState());
  }


  DoctorMainModel? doctorMainModel;

  void getDoctorMain() async {
    try {
      Response response =
          await DioHelper.getData(url: doctorMainInfo, query: {'doctorID': uId});

      doctorMainModel = DoctorMainModel.fromJson(response.data);
      emit(GetDoctorMainSuccessState());
    } catch (error) {
      print(error.toString());
      emit(GetDoctorMainErrorState(error.toString()));
    }
  }

  void editDoctorName(String newName) async {
    try {
      Response response = await DioHelper.postData(
          url: doctorEditName, data: {'doctorID': uId, 'newName': newName});
      print(response.data);
      emit(EditDoctorNameSuccessState());
    } catch (error) {
      print(error.toString());
      emit(EditDoctorNameErrorState(error.toString()));
    }
  }

  void editDoctorTitle(String newTitle) async {
    try {
      Response response = await DioHelper.postData(
          url: doctorEditTitle, data: {'doctorID': uId, 'newTitle': newTitle});
      print(response.data);
      emit(EditDoctorTitleSuccessState());
    } catch (error) {
      print(error.toString());
      emit(EditDoctorTitleErrorState(error.toString()));
    }
  }

  void editDoctorBirthDate(String newBirthDate) async {
    try {
      Response response = await DioHelper.postData(
          url: doctorEditBirthdate,
          data: {'doctorID': uId, 'newBirthDate': newBirthDate});
      print(response.data);
      emit(EditDoctorBirthDateSuccessState());
    } catch (error) {
      print(error.toString());
      emit(EditDoctorBirthDateErrorState(error.toString()));
    }
  }

  void editDoctorProfileImage(String imageName) async {
    try {
      Response response = await DioHelper.postData(
          url: doctorEditImage, data: {'doctorID': uId, 'imageName': imageName});
      print(response.data);
      emit(EditDoctorProfileImageSuccessState());
    } catch (error) {
      print(error.toString());
      emit(EditDoctorProfileImageErrorState(error.toString()));
    }
  }

  void editDoctorDescription(String newDescription) async {
    try {
      Response response = await DioHelper.postData(
          url: doctorEditDescription,
          data: {'doctorID': uId, 'newDescription': newDescription});
      print(response.data);
      emit(EditDoctorDescriptionSuccessState());
    } catch (error) {
      print(error.toString());
      emit(EditDoctorDescriptionErrorState(error.toString()));
    }
  }







  void editPatientName(String newName) async {
    try {
      Response response = await DioHelper.postData(
          url: patientEditName, data: {'patientID': uId, 'newName': newName});
      print(response.data);
      emit(EditPatientNameSuccessState());
    } catch (error) {
      print(error.toString());
      emit(EditPatientNameErrorState(error.toString()));
    }
  }


  void editPatientBirthDate(String newBirthDate) async {
    try {
      Response response = await DioHelper.postData(
          url: patientEditBirthdate,
          data: {'patientID': uId, 'newBirthDate': newBirthDate});
      print(response.data);
      emit(EditPatientBirthDateSuccessState());
    } catch (error) {
      print(error.toString());
      emit(EditPatientBirthDateErrorState(error.toString()));
    }
  }

  void editPatientLanguage(String language) async {
    try {
      Response response = await DioHelper.postData(
          url: patientEditLanguage, data: {'patientID': uId, 'language': language});
      print(response.data);
      emit(EditPatientLanguageSuccessState());
    } catch (error) {
      print(error.toString());
      emit(EditPatientLanguageErrorState(error.toString()));
    }
  }


  void editPatientProfileImage() async {
    try {
      Response response = await DioHelper.postData(
          url: patientEditProfileImage, data: {'patientID': uId, 'imageName': profilePicServer});
      print(response.data);
      emit(EditPatientProfileImageSuccessState());
    } catch (error) {
      print(error.toString());
      emit(EditPatientProfileImageErrorState(error.toString()));
    }
  }


  File? pickedImageProfile;

  Future<void> pickImageProfile(context) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      pickedImageProfile = File(pickedFile!.path);
      print(pickedImageProfile!.path.split(Platform.pathSeparator).last);
      uploadProfilePic(pickedImageProfile!, context);
      emit(PickProfilePicSuccessState());
    } catch (error) {
      print(error.toString());
      emit(PickProfilePicErrorState(error.toString()));
    }
  }

  var profilePicServer;

  void setImageProfile(String imageName) {
    profilePicServer = imageName;
    emit(SetProfileImageSuccessState());
  }

  Future<void> uploadProfilePic(File file, context) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: file.path.split(Platform.pathSeparator).last),
      // Add any other fields you need to send along with the image
    });
    try {
      Response response = await DioHelper.postData(
        url: uploadProfilePhoto,
        data: formData,
        options: Options(
          headers: {
            "contentType": 'multipart/form-data',
          }, // Ensure the content type is set to multipart/form-data
        ),
      );
      setImageProfile(response.data);
      print('pppppp : $profilePicServer');
      emit(UploadProfilePicSuccessState());
    } catch (error) {
      print(error.toString());
      emit(UploadProfilePicErrorState(error.toString()));
    }
  }


  void changeLanguage(String language,String code){
    language=code;
    emit(ChangeLanguage());
  }


}







class ItemServices {
  String assetsService;
  String nameServices;

  ItemServices(this.assetsService, this.nameServices);
}

class ItemTest {
  String assetsService;
  Function function;

  ItemTest(this.assetsService, this.function);
}
