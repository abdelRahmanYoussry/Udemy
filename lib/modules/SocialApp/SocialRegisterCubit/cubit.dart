import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/models/SocialAppModel/socialUserModel.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialRegisterCubit/state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit(initialState) : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context)=>BlocProvider.of(context);

  void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone
}){
FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password
).then((value) {
  emit(SocialRegisterLoadingState());
  print(value.user!.email);
  print(value.user!.uid);
  userCreate(
      email: email,
      name: name,
      phone: phone,
      uid: value.user!.uid);
}
).catchError((error){
  emit(SocialRegisterErrorState(error));
});
  }

  void userCreate({
     String ?email,
    required String name,
    required String phone,
    String ?uid,
  })
  {
    SocialUserModel model=SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        uid: uid,
        coverImage: 'https://image.freepik.com/free-photo/penne-pasta-tomato-sauce-with-chicken-tomatoes-wooden-table_2829-19744.jpg',
        bio: 'Write Your bio.........',
        image: 'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
        isEmailVerified: false);
    FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .set(model.toMap())
    .then((value) {
      emit(SocialCreateUserSuccessState());
})
    .catchError((error){
      emit(SocialCreateUserErrorState(error));
});
}
IconData suffix=Icons.visibility_outlined;
 bool isPassword=false;
  void changePasswordVisibility()
  {
   isPassword=!isPassword;
   suffix=isPassword ? Icons.visibility_outlined:Icons.visibility_off;
   emit(SocialRegisterPasswordVisibility());
  }
}