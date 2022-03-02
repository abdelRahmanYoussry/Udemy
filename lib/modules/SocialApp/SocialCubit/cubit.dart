import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_fluttter/models/SocialAppModel/CommentModel.dart';
import 'package:udemy_fluttter/models/SocialAppModel/PostModel.dart';
import 'package:udemy_fluttter/models/SocialAppModel/socialUserModel.dart';
import 'package:udemy_fluttter/modules/SocialApp/Chats/chats_Screen.dart';
import 'package:udemy_fluttter/modules/SocialApp/Feeds/feeds_Screen.dart';
import 'package:udemy_fluttter/modules/SocialApp/NewPost/newPost.dart';
import 'package:udemy_fluttter/modules/SocialApp/Settings/Settings_Screen.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/state.dart';
import 'package:udemy_fluttter/modules/SocialApp/Users/users_Screen.dart';
import 'package:udemy_fluttter/shared/components/constans.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit(SocialStates initialState) : super(SocialInitialState());

  static SocialCubit get(context)=>BlocProvider.of(context);

   SocialUserModel ?userModel;
   CommentModel? commentModel;

  void getUserData(){
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
         userModel=SocialUserModel.fromJson(value.data()!);
          emit(SocialGetUserSuccessState());
    })
        .catchError((error){
           print(error.toString());
          emit(SocialGetUserErrorState(error.toString()));
    });
  }

int currentIndex=0;
List <Widget> screens=[
FeedsScreen(),
ChatScreen(),
NewPostScreen(),
UsersScreen(),
SettingsScreen(),
];
  List <String> titles=[
    'Home',
    'Chat',
    'Post',
    'Users',
    'Setting'
  ];
  void changeNavBar(int index){
    if(index==2)
      emit(SocialNewPostState());
    else{
      currentIndex=index;
    emit(SocialChangeNavBarState());
    }
      }
// Pick an image
  File? profileImageFile;
  var picker=ImagePicker();
  Future getProfileImage()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile !=null){
       profileImageFile=File(pickedFile.path);
       print(pickedFile.path.toString());
    emit(SocialEditUserProfileImageSuccessState());
    }else
      {
        print('No Image Selected');
        emit(SocialEditUserProfileImageErrorState());}
        
  }

  File? coverImageFile;
  Future getCoverImage()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile !=null){
      coverImageFile=File(pickedFile.path);
      emit(SocialEditUserCoverImageSuccessState());
    }else
    {
      print('No Image Selected');
      emit(SocialEditUserCoverImageErrorState());}
  }
  
  //uploadImageFireBase

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }){
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref()
    .child('users/${Uri.file(profileImageFile!.path).pathSegments.last}')
     .putFile(profileImageFile!).then((value)  {
       value.ref.getDownloadURL().then((value) {
         print(value);
        updateUser(name: name, phone: phone, bio: bio,
        image: value,);
         emit(SocialUpdateUserProfileImageSuccessState());

       }).catchError((error){
         emit(SocialUpdateUserProfileImageErrorState());
       });
    }).catchError((error){
      emit(SocialUpdateUserProfileImageErrorState());
    });
  }


  void uploadCoverImage({required String name,
    required String phone,
    required String bio,}){
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(coverImageFile!.path).pathSegments.last}')
        .putFile(coverImageFile!).then((value)  {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, bio: bio,cover: value);
       // emit(SocialUpdateUserCoverImageSuccessState());

      }).catchError((error){
        emit(SocialUpdateUserCoverImageErrorState());
      });
    }).catchError((error){
      emit(SocialUpdateUserCoverImageErrorState());
    });
  }

  void updateUser({
  required String name,
  required String phone,
  required String bio,
  String ?image,
  String ?cover,

}){
    // emit(SocialUpdateLoadingState());
    SocialUserModel modelMap=SocialUserModel(
        name: name,
        phone: phone,
        bio: bio,
        coverImage:cover?? userModel!.coverImage,
        image: image?? userModel!.image,
        email:   userModel!.email,
        uid:    userModel!.uid,
        isEmailVerified: false
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(modelMap.toMap())
        .then((value) {
        getUserData();
    })
        .catchError((error){
      emit(SocialUpdateErrorState());
    });

  }
//Posts Functions
  File? postImageFile;
  Future getPostImage()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile !=null){
      postImageFile=File(pickedFile.path);
      emit(SocialPostImageSuccessState());
    }else
    {
      print('No Image Selected');
      emit(SocialPostImageErrorState());}
  }

 void removePostImage(){
    postImageFile=null;
    emit(SocialRemovePostImageState());
 }
  void uploadPostImage({
    required String dateTime,
    required String text,

  })
  {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref()
        .child('posts/${Uri.file(postImageFile!.path).pathSegments.last}')
        .putFile(postImageFile!).then((value)  {
      value.ref.getDownloadURL().then((value) {
        print(value);
       createPost(
           dateTime: dateTime,
           text: text,
          postImage: value,
       );

      }).catchError((error){
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
    String? comment,

  }){
    emit(SocialCreatePostLoadingState());
    PostModel postmodel=PostModel(
        name: userModel!.name,
        image:userModel!.image,
        uid: userModel!.uid,
        dateTime: dateTime,
        text:text,
        postImage: postImage??'',
       comment: comment??''
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postmodel.toMap())
        .then((value) {
          emit(SocialCreatePostSuccessState());
    }
    )
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });

  }
  List<PostModel>postList=[];
  List<String>postId=[];
  String ?postIdNew;
  List<int>likesCountList=[];
  List<int>commentCountList=[];

 void getPost(){
    // emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            //new
            element.reference.collection('Comments')
            .doc(userModel!.uid)
            .collection('user Comment')
            .get()
            .then((value) {
              // print(value.docs.length);
             commentCountList.add(value.docs.length);
             postId.add(element.id);
              // print(commentCountList);m
              element.reference.collection('Likes')
                  .get()
                  .then((value){
                likesCountList.add(value.docs.length);
                postId.add(element.id);
                postList.add(PostModel.fromJson(element.data()));
                emit(SocialGetPostsSuccessState());
            }).catchError((error){});
            //original
            // element.reference.collection('Likes')
            // .get()
            // .then((value){
            //   likesCountList.add(value.docs.length);
            //   postId.add(element.id);
            //  postList.add(PostModel.fromJson(element.data()));
            //    emit(SocialGetPostsSuccessState());
            })
            .catchError((error){});
          });

          emit(SocialGetPostsSuccessState());
    }
    )
         .catchError((error){
           emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId){
    FirebaseFirestore.instance
    .collection('posts')
    .doc(postId)
    .collection('Likes')
    .doc(userModel!.uid)
    .set({
      'like':true,
    })
    .then((value) {
      emit(SocialLikePostsSuccessState());
    })
    .catchError((error){
      emit(SocialLikePostsErrorState(error.toString()));
    });
  }

  void createComment({required String postId,required String comment,required String dataTime}){
    emit(SocialCreateCommentPostsLoadingState());
    // commentList.add(comment);
    // print(_commentModel!.text??'null');
    CommentModel commentModel=CommentModel(
      name: userModel!.name,
      image:userModel!.image,
      uid: userModel!.uid,
      text:comment,
      dateTime:dataTime ,
    );
   FirebaseFirestore.instance
.collection('posts')
.doc(postId)
.collection('Comments')
.doc(userModel!.uid)
 .collection('user Comment')
.add(commentModel.toMap()
).then((value) {
  emit(SocialCreateCommentPostsSuccessState());
})
  .catchError((error){
  emit(SocialCreateCommentPostsErrorState(error.toString()));

});

 }


  List<String> commentList=[];
  List<CommentModel> commentModelList=[];
  void getComments(String postId){
    emit(SocialGetCommentPostsLoadingState());
   FirebaseFirestore.instance
   .collection('posts')
   .doc(postId)
    .collection('Comments')
    .doc(userModel!.uid)
     .collection('user Comment')
     .get()
     .then((value) {
       commentModelList.clear();
       // commentList.clear();
       value.docs.forEach((element) {
       commentModel=   CommentModel.fromJson(element.data());
         commentModelList.add(CommentModel.fromJson(element.data()));
         commentList.add(element.id);
  //  emit(SocialGetCommentPostsSuccessState());
       });
       emit(SocialGetCommentPostsSuccessState());
       }).catchError((error){
     emit(SocialGetCommentPostsErrorState(error.toString()));
     print(error);
   });
   }

 }
