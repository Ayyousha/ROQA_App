
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/models/users_models.dart';
import 'package:roqasocial/modules/register/cubit/states.dart';


class RoqaRegisterCubit extends Cubit<RoqaRegisterStates>
{
  RoqaRegisterCubit()  : super(initialState());
  static RoqaRegisterCubit get(context) => BlocProvider.of(context);





  UsersModels? usersModels;
  void registerUsers({
    required String name,
    required String email,
    required String password,
    required String phone,
})
  {
    emit(RegisterUsersLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email,
        password: password,
    )
        .then((value)
    {
      createUsers(
          uId: value.user!.uid,
          name: name,
          email: email,
          password: password,
          phone: phone,

      );
    }).catchError((error)
    {
      emit(RegisterUsersErrorState(error));
    });
  }

 void createUsers({
  required String name,
  required String email,
  required String password,
  required String phone,
  required String uId,
})
 {
   emit(CreateUsersLoadingState());
   UsersModels models = UsersModels(
     uId: uId,
     name: name,
     email: email,
     password: password,
     phone: phone,
     image: 'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
     cover: 'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
     bio: 'Iam Software Engineer',
   );
   FirebaseFirestore.instance
       .collection('users')
       .doc(uId)
       .set(models.toJson())
       .then((value)
   {
     emit(CreateUsersSuccessState(uId));
   }).catchError((error)
   {
     emit(CreateUsersErrorState(error));
   });

 }

  /// Change Suffix Icon & Pass Visibility
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changeSuffix()
  {
    isPassword = !isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSuffixState());
  }
}