import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/models/ShopAppModel/loginModel.dart';
import 'package:udemy_fluttter/models/SocialAppModel/socialUserModel.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopLoginCubit/state.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialLoginCubit/state.dart';
import 'package:udemy_fluttter/shared/components/constans.dart';
import 'package:udemy_fluttter/shared/network/EndPoints.dart';
import 'package:udemy_fluttter/shared/network/remote/dio_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit(initialState) : super(SocialLoginInitialState());
  static SocialLoginCubit get(context)=>BlocProvider.of(context);

//SocialUserModel? model;
  void userLogin({
  required String email,
  required String password
}){
    emit(SocialLoginLoadingState());
 FirebaseAuth.instance.signInWithEmailAndPassword(
     email: email,
     password: password).then((value)
 {
   emit(SocialLoginSuccessState(value.user!.uid));
 }
 ).catchError((error)
 {
   emit(SocialLoginErrorState(error.toString()));

 });
  }


IconData suffix=Icons.visibility_outlined;
 bool isPassword=true;
  void changePasswordVisibility()
  {
   isPassword=!isPassword;
   suffix=isPassword ? Icons.visibility_outlined:Icons.visibility_off;
   emit(SocialLoginPasswordVisibility());
  }
}