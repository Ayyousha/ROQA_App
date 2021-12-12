
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/modules/login/cubit/states.dart';


class RoqaLoginCubit extends Cubit<RoqaLoginStates>
{
  RoqaLoginCubit()  : super(initialState());
  static RoqaLoginCubit get(context) => BlocProvider.of(context);


  /// Change Suffix Icon & Pass Visibility
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changeSuffix()
  {
    isPassword = !isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSuffixState());
  }

  void userLogin({
    required String email,
    required String password,
})
  {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error)
    {
      emit(LoginErrorState(error.toString()));
    });
  }

}