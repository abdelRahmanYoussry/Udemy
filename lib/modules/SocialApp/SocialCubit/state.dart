import 'package:flutter/cupertino.dart';

abstract class SocialStates{}


class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);
}
class SocialChangeNavBarState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialEditUserProfileImageSuccessState extends SocialStates{}

class SocialEditUserProfileImageErrorState extends SocialStates{}

class SocialEditUserCoverImageSuccessState extends SocialStates{}

class SocialEditUserCoverImageErrorState extends SocialStates{}

class SocialUpdateUserProfileImageSuccessState extends SocialStates{}

class SocialUpdateUserProfileImageErrorState extends SocialStates{}

class SocialUpdateUserCoverImageSuccessState extends SocialStates{}

class SocialUpdateUserCoverImageErrorState extends SocialStates{}

class SocialUpdateErrorState extends SocialStates{}

class SocialUpdateLoadingState extends SocialStates{}
//create Post State
class SocialCreatePostErrorState extends SocialStates{}
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}

//create Post image State
class SocialPostImageSuccessState extends SocialStates{}
class SocialPostImageErrorState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}

//get Posts
class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;
  SocialGetPostsErrorState(this.error);
}

class SocialLikePostsSuccessState extends SocialStates{}
class SocialLikePostsErrorState extends SocialStates{
  final String error;
  SocialLikePostsErrorState(this.error);
}
class SocialCreateCommentPostsLoadingState extends SocialStates{}
class SocialCreateCommentPostsSuccessState extends SocialStates{}
class SocialCreateCommentPostsErrorState extends SocialStates{
  final String error;
  SocialCreateCommentPostsErrorState(this.error);
}

class SocialGetCommentPostsLoadingState extends SocialStates{}
class SocialGetCommentPostsSuccessState extends SocialStates{}
class SocialGetCommentPostsErrorState extends SocialStates{
  final String error;
  SocialGetCommentPostsErrorState(this.error);
}

