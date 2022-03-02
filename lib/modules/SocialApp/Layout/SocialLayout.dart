import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udemy_fluttter/modules/SocialApp/NewPost/newPost.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/cubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/state.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/styles/styles.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if (state is SocialNewPostState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          actions: [
            IconButton(icon: Icon(IconBroken.Notification),onPressed: (){},),
            IconButton(icon: Icon(IconBroken.Search),onPressed: (){},)
          ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
             cubit.changeNavBar(index);
            },
            items: [
              BottomNavigationBarItem(icon:Icon(IconBroken.Home)
                  ,label: 'Home'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Chat) ,
                  label: 'Chat'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Paper_Upload) ,
                  label: 'Post'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Location) ,
                  label: 'Users'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Setting) ,
                  label: 'Setting'),
            ],
          ),
        );
      },
    );
  }
}
