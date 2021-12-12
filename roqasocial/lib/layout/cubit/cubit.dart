
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roqasocial/layout/cubit/states.dart';
import 'package:roqasocial/models/comments_models.dart';
import 'package:roqasocial/models/messages_models.dart';
import 'package:roqasocial/models/post_models.dart';
import 'package:roqasocial/models/users_models.dart';
import 'package:roqasocial/modules/chat/chat_screen.dart';
import 'package:roqasocial/modules/home/home_screen.dart';
import 'package:roqasocial/modules/login/login_screen.dart';
import 'package:roqasocial/modules/on_boarding/onBoarding_screen.dart';
import 'package:roqasocial/modules/profile/profile_screen.dart';
import 'package:roqasocial/modules/register/register_screen.dart';
import 'package:roqasocial/modules/users/users_screen.dart';
import 'package:roqasocial/shared/components/components.dart';
import 'package:roqasocial/shared/components/constance.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:roqasocial/shared/network/local/cache_helper.dart';

class RoqaMainCubit extends Cubit<RoqaMainStates>
{
  RoqaMainCubit()  : super(initialState());
  static RoqaMainCubit get(context) => BlocProvider.of(context);

  var boardController = PageController();
  /// List of on Boarding Photo
  List<Widget> boarding = [
    LoginScreen(),
    RegisterScreen(),
  ];

  
  int currentIndex = 0;
  List<Widget> Screens =
  [
    HomeScreen(),
    ChatScreen(),
    UsersScreen(),
    ProfileScreen(),
  ];
  
  setBottomBarIndex(index) {
   currentIndex = index;
   emit(changeBottomNavState());
  }

  UsersModels? usersModels;
  void getUsers()
  {
    emit(getUsersDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value)
    {
      usersModels = UsersModels.fromJson(value.data()!);
      print(value.data().toString());
      emit(getUsersDataSuccessState());
    }).catchError((error)
    {
      emit(getUsersDataErrorState(error.toString()));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }


  File? ProfileImage;

  Future<void> getProfileImage() async
  {
    emit(getProfileImageLoadingState());
   var pickerImage = await picker.pickImage(source: ImageSource.gallery);
   if(pickerImage != null) {
     ProfileImage = File(pickerImage.path);
     emit(getProfileImageSuccessState());
   }else
     {
       print('Sorry we cant found any photo');
       emit(getProfileImageErrorState());
     }
  }


  File? CoverImage;
  var picker = ImagePicker();
  Future<void> getCoverImage() async
  {
    emit(getCoverImageLoadingState());
    var pickerImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickerImage != null) {
      CoverImage = File(pickerImage.path);
      emit(getCoverImageSuccessState());
    }else
    {
      print('Sorry we cant found any photo');
      emit(getCoverImageErrorState());
    }
  }


  void uploadProfileImage({
  required String name,
  required String bio,
  required String phone,
})
  {
    emit(uploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!)
        .then((value) {
          value.ref.getDownloadURL().then((value)
          {
            updateUserData(
              name: name,
              bio: bio,
              phone: phone,
              image: value,
            );
          }).catchError((error)
          {
            emit(uploadProfileImageErrorState(error));
          });
    }).catchError((error)
    {
      emit(uploadProfileImageErrorState(error));
    });
  }

  void uploadCoverImage(
  {
    required String name,
    required String bio,
    required String phone,
})
  {
    emit(uploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
    .ref()
    .child('users/${Uri.file(CoverImage!.path).pathSegments.last}')
    .putFile(CoverImage!)
    .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        updateUserData(
            name: name,
            bio: bio,
            phone: phone,
            cover: value,
      );
      }).catchError((error)
      {
        emit(uploadProfileImageErrorState(error));
      });
    }).catchError((error)
    {
      emit(uploadCoverImageErrorState(error));
    });
  }


  void updateUserData({
  required String name,
  required String bio,
  required String phone,
   String? image,
   String? cover,
})
  {
    emit(updateUserDataLoadingState());
    UsersModels models = UsersModels(
      uId: uId,
      name: name,
      email: usersModels!.email,
      password: usersModels!.password,
      image: image ?? usersModels!.image,
      bio: bio,
      cover: cover ?? usersModels!.cover,
      phone: phone,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(usersModels!.uId)
        .update(models.toJson())
        .then((value)
    {
     getUsers();
     getPostData();
    }).catchError((error)
    {
     emit(updateUserDataErrorState(error));
    });
  }


  File? PostImage;
  Future<void> getPostImage() async
  {
    emit(getPostImageLoadingState());
   final pickerImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickerImage != null){
      PostImage=File(pickerImage.path);
      emit(getPostImageSuccessState());
    }else
      {
        print('Sorry we can\'t Found any photo');
        emit(getPostImageErrorState());
      }
  }

  void removePostImage()
  {
    PostImage = null;
    emit(removePostImageState());
  }

  void uploadPostImage(
      {
        required String text,
        required String hashTag,
        required String dateTime,
      })
  {
    emit(uploadPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        createPost(
          text: text,
          dateTime: dateTime,
          imagePost: value,
          hashTag: hashTag,
        );
      }).catchError((error)
      {
        emit(uploadPostImageErrorState(error));
      });
    }).catchError((error)
    {
      emit(uploadPostImageErrorState(error));
    });
  }




  void createPost({
  required String text,
   String? hashTag,
  required String dateTime,
   String? imagePost,

})
  {
    emit(createPostLoadingState());
    PostModels models = PostModels(
      uId: usersModels!.uId,
      name: usersModels!.name,
      image: usersModels!.image,
      bio: usersModels!.bio,
      cover: usersModels!.cover,
      dateTime: dateTime,
      imagePost: imagePost??'',
      text: text,
      hashTag: hashTag??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(models.toJson())
    .then((value)
    {
      emit(createPostSuccessState());
      getPostData();

    }).catchError((error)
    {
      emit(createPostErrorState(error));
    });

  }

  List<PostModels> postModel = [];
  List<String> postId = [];
  // List<String> commentUId = [];
  List<int> likes = [];
  // List<int> comments = [];

  /// get Post Data With SnapShot
  void getPostData()
  {
    postModel = [];
    emit(getPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .listen((event)
    {

      postModel = [];
      event.docs.forEach((element) {
          element.reference
          .collection('likes')
              .snapshots()
              .listen((event)
          {

            likes.add(event.docs.length);
            postId.add(element.id);

              postModel.add(PostModels.fromJson(element.data()));
              emit(getPostSuccessState());
          }).onError((error)
          {
            emit(getPostErrorState(error.toString()));
          });
      });
        }).onError((error)
        {
          emit(getPostErrorState(error.toString()));
        });
  }


  /// get Post Data Without SnapShot
  // void getPostData()
  // {
  //   postModel = [];
  //   emit(getPostLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .get()
  //       .then((value)
  //   {
  //     value.docs.forEach((element) {
  //       element.reference
  //           .collection('comments')
  //           .get()
  //           .then((value)
  //       {
  //         // comments.add(value.docs.length);
  //         // commentId.add(element.id);
  //         // element.reference
  //         //     .collection('likes')
  //         //     .get()
  //         //     .then((value)
  //         // {
  //           likes.add(value.docs.length);
  //           postId.add(element.id);
  //           postModel.add(PostModels.fromJson(element.data()));
  //           emit(getPostSuccessState());
  //         // }).catchError((error)
  //         // {
  //         //   emit(getPostErrorState(error));
  //         // });
  //         }).catchError((error)
  //       {
  //         emit(getPostErrorState(error));
  //       });
  //       emit(getPostSuccessState());
  //     });
  //
  //   }).catchError((error)
  //   {
  //     emit(getPostErrorState(error));
  //   });
  // }


  void putLike(
      String postId,
      // String postUId,
  )
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(usersModels!.uId)
        .set({
          'like':true,
        }).then((value)
    {
      emit(putLikeSuccessState());
    }).catchError((error)
    {
      emit(putLikeErrorState(error));
    });
  }


  List<CommentModels> commentId = [];
  CommentModels? commentModels;
  void createComment({
    required String text,
    String? hashTag,
    String? imagePost,
    // String? commentId,

  })
  {
    commentId = [];
    emit(createCommentLoadingState());
    CommentModels models = CommentModels(
      name: usersModels!.name,
      image: usersModels!.image,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('comments')
        .add(models.toJson())
        .then((value)
    {
      emit(createCommentSuccessState());
    }).catchError((error)
    {
      emit(createCommentErrorState(error));
    });

  }

  void getComments()
  {
    commentId = [];
    emit(getCommentLoadingState());
    FirebaseFirestore.instance
        .collection('comments')
        .snapshots()
        .listen((event)
    {
      commentId = [];
      event.docs.forEach((element) {
        commentId.add(CommentModels.fromJson(element.data()));
      });
      emit(getCommentSuccessState());
    }).onError((error)
    {
      emit(getCommentErrorState(error.toString()));
    });
  }




  List<UsersModels> allUsers = [];
  void getAllUsers()
  {
    allUsers = [];
    if(allUsers.length == 0)
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((value)
    {
      allUsers = [];
      value.docs.forEach((element)
      {
        if(element.data()['uId'] != usersModels!.uId )
        allUsers.add(UsersModels.fromJson(element.data()));
        emit(getAllUsersSuccessState());
      });
    }).onError((error)
    {
      emit(getAllUsersErrorState(error.toString()));
    });
  }


  void sendMessage({
  required String receiverUId,
  required String message,
  required String dateTime,
})
  {
    MessagesModels models = MessagesModels(
      senderUId: usersModels!.uId,
      receiverUId: receiverUId,
      message: message,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(usersModels!.uId)
        .collection('chats')
        .doc(receiverUId)
        .collection('messages')
        .add(models.toJson())
        .then((value)
    {
      emit(sendMessageSuccessState());
    }).catchError((error)
    {
      emit(sendMessageErrorState(error));
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverUId)
        .collection('chats')
        .doc(usersModels!.uId)
        .collection('messages')
        .add(models.toJson())
        .then((value)
    {
      emit(receiveMessageSuccessState());
    }).catchError((error)
    {
      emit(receiveMessageErrorState(error));
    });
  }

  List<MessagesModels> Messages = [];
  void getMessage({
    required String receiverUId,

  })
  {
    Messages = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(usersModels!.uId)
        .collection('chats')
        .doc(receiverUId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      Messages = [];
      event.docs.forEach((element)
      {
        Messages.add(MessagesModels.fromJson(element.data()));
        emit(getMessageSuccessState());
      });
    });
  }



  Future<void> refresh()
  async {
    getUsers();
    getPostData();
    getAllUsers();
    getComments();
    return Future.delayed(
        Duration(seconds: 3),
    );
  }


  void signOut(context)
  {

    CacheHelper.removeData(key: 'uId').then((value)
    {
      if(value)
      {

        NavigateAndFinish(context, OnBoardingScreen());
      }
      FirebaseAuth.instance.signOut();
    });
  }

}