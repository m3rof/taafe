import 'dart:io';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:taafe/modules/medical_record/mediacal_record_screen.dart';
import 'package:taafe/modules/posts/patient_posts_screen.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/network/remote/dio_helper.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import '../../../models/doctor_models/doctor_main_model.dart';
import '../../../models/patient_model/patient_info_model.dart';
import '../../../models/patient_model/patient_main_info_model.dart';
import '../../../modules/edit_profile/edit_profile_screen.dart';
import '../../../modules/navigation_bar_items/blogs/blogs_screen.dart';
import '../../../modules/navigation_bar_items/blogs/widget/category_screen.dart';
import '../../../modules/navigation_bar_items/communities/communities_screen.dart';
import '../../../modules/navigation_bar_items/q_a/q_a_screen.dart';
import '../../../modules/navigation_bar_items/test/test_screen.dart';
import '../../../modules/navigation_bar_items/therapists/therapists_screen.dart';
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
                doctorMainModel!.name,
                doctorMainModel!.birthDate,
                doctorMainModel!.profileImage,
                doctorMainModel!.title,
                doctorMainModel!.description,
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
        onTap: () {},
        title: Text('About Us'),
      )),
      PopupMenuItem(
          child: ListTile(
        onTap: () {},
        title: Text('Logout'),
      )),
    ];
  }

  PateintMainModel? pateintMainModel;

  void getPatientMain() {
    DioHelper.getData(url: patientMainInfo, query: {'patientID': 1})
        .then((value) {
      pateintMainModel = PateintMainModel.fromJson(value.data);
      emit(GetPatientMainSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(GetPatientMainErrorState());
    });
  }

  PatientInfoModel? patientInfoModel;

  void getPatientInfo() {
    DioHelper.getData(url: patientInfo, query: {'patientID': 1}).then((value) {
      patientInfoModel = PatientInfoModel.fromJson(value.data);
      emit(GetPatientInfoSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(GetPatientInfoErrorState());
    });

    XFile? pickedImage;

    Future<void> pickImage() async {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.camera);
      pickedImage = pickedFile;
      emit(HomePickImageState());
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

  List hobby = [];

  // void getHobby() {
  //   DioHelper.getData(url: patientHobby, query: {'patientID': 1}).then((value) {
  //     hobby = value.data;
  //     print(hobby);
  //     emit(HomeGetHobbySuccessState());
  //   }).catchError((Error) {
  //     print(Error.toString());
  //     emit(HomeGetHobbyErrorState());
  //   });
  // }
  //
  // void sendHobby(int patientID, String hobby) {
  //   DioHelper.postData(url: patientHobby, data: {
  //     'patientID': patientID,
  //     'hobby': hobby,
  //   }).then((value) {
  //     print(value.data);
  //   }).catchError((Error) {
  //     print(Error.toString());
  //   });
  // }
  //
  // void deleteHobby(int patientID, int hobbyID, String role) {
  //   DioHelper.deleteData(
  //     url: patientHobby,
  //     data: {'patientID': patientID, 'hobbyID': hobbyID, 'role': role},
  //   ).then((value) {
  //     print(value.data);
  //   }).catchError((Error) {
  //     print(Error.toString());
  //   });
  // }
  //
  // List diagnose=[];
  // void getDiagnose() {
  //   DioHelper.getData(url: patientDiagnose, query: {'patientID': 1}).then((value) {
  //     diagnose = value.data;
  //     print(diagnose);
  //     emit(HomeGetDiagnoseSuccessState());
  //   }).catchError((Error) {
  //     print(Error.toString());
  //     emit(HomeGetDiagnoseErrorState());
  //   });
  // }
  //
  // List medicine=[];
  // void getMedicine() {
  //   DioHelper.getData(url: patientMedicine, query: {'patientID': 1}).then((value) {
  //     medicine = value.data;
  //     print(medicine);
  //     emit(HomeGetMedicineSuccessState());
  //   }).catchError((Error) {
  //     print(Error.toString());
  //     emit(HomeGetMedicineErrorState());
  //   });
  // }

  DoctorMainModel? doctorMainModel;

  void getDoctorMain() async {
    try {
      Response response =
          await DioHelper.getData(url: doctorMainInfo, query: {'doctorID': 1});

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
          url: doctorEditName, data: {'doctorID': 1, 'newName': newName});
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
          url: doctorEditTitle, data: {'doctorID': 1, 'newTitle': newTitle});
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
          data: {'doctorID': 1, 'newBirthDate': newBirthDate});
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
          url: doctorEditImage, data: {'doctorID': 1, 'imageName': imageName});
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
          data: {'doctorID': 1, 'newDescription': newDescription});
      print(response.data);
      emit(EditDoctorDescriptionSuccessState());
    } catch (error) {
      print(error.toString());
      emit(EditDoctorDescriptionErrorState(error.toString()));
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

  var ProfilePicServer;

  void setImageProfile(String imageName) {
    ProfilePicServer = imageName;
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
      print('pppppp : $ProfilePicServer');
      emit(UploadProfilePicSuccessState());
    } catch (error) {
      print(error.toString());
      emit(UploadProfilePicErrorState(error.toString()));
    }
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
