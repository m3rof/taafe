import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:taafe/models/blog_models/article_model.dart';
import 'package:taafe/modules/navigation_bar_items/blogs/widget/add_post_blog_screen.dart';
import 'package:taafe/modules/navigation_bar_items/communities/communites_cubit/community_state.dart';
import 'package:taafe/shared/network/remote/dio_helper.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/remote/end_points.dart';
import 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(BlogInitialState());

  static BlogCubit get(context) => BlocProvider.of(context);



  List menuCategorySearch=['all'];
  List menuCategory=[];

  void addCategory(){
    for(var e in category){
      menuCategory.add(e['category']);
      menuCategorySearch.add(e['category']);
    }
  }
  List category=[];


  void getListCategory() {
    emit(BlogInitialState());
    DioHelper.getData(url: blogCategory,query: {'loadBlock': 1}).then((value) {
      print(value.data);
      category = value.data;
      addCategory();
      emit(BlogCategorySuccessState());
    }).catchError((Error) {
      print(Error);
      emit(BlogCategoryErrorState());
    });
  }


  int categorySelected=0;
  bool isSelected=false;
  void selectCategory(int index){

    // categorySelected=index;
    // if(categorySelected==index){
    //   isSelected=true;
    // }else{
    //   isSelected=false;
    // }
    emit(BlogInitialState());
    isSelected =! isSelected;
    print(isSelected);
    emit(BlogsCategorySelectedState());
  }

  void checkValidation({
    required GlobalKey<FormState> key,
    required TextEditingController categoryName,
    required TextEditingController description,
  }) {
    if (key.currentState!.validate()) {
      createCategory(categoryName.text, description.text);
      emit(BlogsValidationCategoryState());
    }
  }

  void createCategory(String categoryName,String description) {
    emit(BlogInitialState());
    DioHelper.postData(url: blogCreateCategory, data: {'doctorID': 1,'categoryName':categoryName,'description':description}).then((value) {
      print(value.data);
      emit(BlogCategorySuccessState());
    }).catchError((Error) {
      print(Error);
      emit(BlogCategoryErrorState());
    });
  }

  List searchArticle = [];


  void getSearchArticle(String search) {
    emit(BlogInitialState());
    DioHelper.getData(url: blogListArticle, query: {
      'loadBlock': 1,
      'searchText': search,
      'categoryID': 1,
    }).then((value) {
      print(value.data);
      if (search.isNotEmpty) {
        searchArticle = value.data;
        print(searchArticle);
      } else {
        searchArticle = [];
        print(searchArticle);
      }
      emit(BlogSearchArticleSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(BlogSearchArticleErrorState());
    });
  }

  List listArticle=[];

  void getListArticle(int categoryId) {
    emit(BlogInitialState());
    DioHelper.getData(url: blogListArticle, query: {
      'loadBlock': 1,
      'categoryID': categoryId,
    }).then((value) {
      listArticle = value.data;
        print(listArticle);
      emit(BlogListArticleSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(BlogListArticleErrorState());
    });
  }

  BlogArticleModel? blogArticleModel;

  void getArticleID(int articleId) {
    emit(BlogInitialState());
    DioHelper.getData(url: blogArticleID, query: {
      'articleID': articleId,
    }).then((value) {
      blogArticleModel = BlogArticleModel.fromJson(value.data);
      emit(BlogListArticleSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(BlogListArticleErrorState());
    });
  }

  List comments=[];

  void getCommentsID(int articleId,int loadBlock) {
    emit(BlogInitialState());
    DioHelper.getData(url: blogCommentID, query: {
      'articleID': articleId,
      'loadBlock':loadBlock
    }).then((value) {
      comments = value.data;
      emit(BlogGetCommentsSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(BlogGetCommentsErrorState());
    });
  }

  void checkValidationPost({required context,
    required GlobalKey<FormState> key,
    required TextEditingController title,
    required TextEditingController mainText,
    required int which,
    required int articleID
  }) {
    if (key.currentState!.validate()) {
      print('vvvvvv : $imageServerName');
      whichFunction(articleID, 1, categoryID, mainText.text, title.text,imageServerName,which);
      print(articleID);
      print(categoryID);
      print(mainText.text);
      print(title.text);

      emit(BlogsValidationArticleState());
    }
  }

  var selectedCategory;
  var categoryID;

  void showResult(value, selectedItem, List category) {
    selectedItem = value;
    for (var e in category) {
      if (selectedItem == e['category']) {
        categoryID = e['id'];
        print(categoryID);
      }
    }
    emit(BlogsDropCategoryState());
  }


  void addPost(int doctorID, int categoryID, String mainText, String title,
      String coverImage) {
    var now = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    String formattedDate = formatter.format(now);
    print(formattedDate);
    DioHelper.postData(url: blogArticleID,
        data: {
      'doctorID': doctorID,
      'categoryID': categoryID,
      'title':title,
      'mainText': mainText,
      'date': formattedDate,
      'coverImage': coverImage,
    },).then((value) {
      print(value.data);
      emit(BlogAddPostSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(BlogAddPostErrorState());
    });
  }

  void editPost(int articleID,
      int doctorID, int categoryID,String title, String mainText, String coverImage) {
    var now = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    String formattedDate = formatter.format(now);
    DioHelper.postData(url: editDoctorPosts, data: {
      'doctorID': doctorID,
      'articleID':articleID,
      'categoryID': categoryID,
      'title':title,
      'mainText': mainText,
      'date': formattedDate,
      'coverImage': coverImage,
    }).then((value) {
      print(value.data);
      emit(BlogEditPostSuccessState());
    }).catchError((Error) {
      print(Error);
      emit(BlogEditPostSuccessState());
    });
  }

  File? pickedImage;

  Future<void> pickImage(context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      pickedImage =File(pickedFile!.path) ;
      print(pickedImage!.path.split(Platform.pathSeparator).last);
    uploadImage(pickedImage!,context);
    emit(BlogsUploadImageState());
  }

  var imageServerName;

  void setImage(String imageName){
    emit(BlogInitialState());
    imageServerName=imageName;
    emit(BlogsSetImageState());
  }

  Future<void> uploadImage(File file,context) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename:file.path.split(Platform.pathSeparator).last),
      // Add any other fields you need to send along with the image
    });
    DioHelper.postData(
      url: uploadPhoto,
      data: formData,
      options: Options(
        headers: {
          "contentType": 'multipart/form-data',
        }, // Ensure the content type is set to multipart/form-data
      ),
    ).then((value) {
      print(value.data);
      setImage(value.data);
      print('uuuuuuuuuuuu : $imageServerName');
    }).catchError((Error) {
      print(Error.toString());
    });
  }


  void whichFunction(int articleID, int doctorID, int categoryID,
      String mainText, String title,String coverImage ,int which) {
    if (which == 1) {
      addPost(doctorID, categoryID, mainText,title,coverImage);
    }
    else {
      editPost(articleID,doctorID, categoryID,title,mainText,coverImage);
    }
  }

  List doctorPosts = [];

  void getDoctorPosts() {
    emit(BlogInitialState());
    DioHelper.getData(url: postsDoctor, query: {'loadBlock': 1, 'doctorID': 1})
        .then((value) {
      print(value.data);
      doctorPosts = value.data;
      emit(BlogsGetPostsSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(BlogsGetPostsErrorState());
    });
  }

  List<PopupMenuEntry> menuePop(context, int idPost, int index) {
    return [
      PopupMenuItem(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(PageTransition(
                  duration: const Duration(milliseconds: 600),
                  type: PageTransitionType.rightToLeft,
                  child: AddPostBlogScreen(2, idPost)));
            },
            leading: Icon(FontAwesomeIcons.edit),
            title: Text('edit post'),
          )),
      PopupMenuItem(
          child: ListTile(
            onTap: () {
              askDialogAwsome(context, 'Are you sure', DialogType.question, () {
                deletePost(idPost, 1);
                doctorPosts.removeAt(index);
                emit(BlogsPostsRemoveItemState());
              });
            },
            leading: Icon(FontAwesomeIcons.trash),
            title: Text('delete post'),
          ))
    ];
  }

  void deletePost(int articleID, int doctorID) {
    DioHelper.deleteData(url: blogArticleID, data: {
      'articleID': articleID,
      'doctorID': doctorID
    }).then((value) {
      print(value.data);
    }).catchError((Error) {
      print(Error);
    });
  }

  void makeAndDeleteLikeDoctor(int doctorID,int articleID,bool likedByUser) {
    emit(BlogInitialState());
    if(likedByUser==false){
      DioHelper.postData(url: blogDoctorUpvote, data: {
        'doctorID':doctorID,
        'articleID':articleID
      }).then((value) {
        print(value.data);
        emit(BlogLikeDoctorSuccessState());
      }).catchError((Error) {
        print(Error.toString());
        emit(BlogLikeDoctorErrorState());
      });
    }
    else{
      DioHelper.deleteData(url: blogDoctorUpvote, data: {
        'doctorID':doctorID,
        'articleID':articleID
      }).then((value) {
        print(value.data);
        emit(BlogDeleteLikeDoctorSuccessState());
      }).catchError((Error) {
        print(Error);
        emit(BlogDeleteLikeDoctorErrorState());
      });
    }
  }

  void makeAndDeleteLikeDoctorComment(int doctorID,int commentID,bool likedByUser) {
    emit(BlogInitialState());
    if(likedByUser==false){
      DioHelper.postData(url: blogDoctorUpvoteComment, data: {
        'doctorID':doctorID,
        'commentID':commentID
      }).then((value) {
        print(value.data);
        emit(BlogLikeDoctorCommentSuccessState());
      }).catchError((Error) {
        print(Error.toString());
        emit(BlogLikeDoctorCommentErrorState());
      });
    }
    else{
      DioHelper.deleteData(url: blogDoctorUpvoteComment, data: {
        'doctorID':doctorID,
        'commentID':commentID
      }).then((value) {
        print(value.data);
        emit(BlogDeleteLikeDoctorCommentSuccessState());
      }).catchError((Error) {
        print(Error);
        emit(BlogDeleteLikeDoctorCommentErrorState());
      });
    }
  }


}
