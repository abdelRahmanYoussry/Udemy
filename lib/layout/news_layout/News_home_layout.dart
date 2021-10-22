import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/modules/search/Search.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/shared/network/remote/dio_helper.dart';
import 'package:udemy_fluttter/shared/news_cubit/news_cubit.dart';
import 'package:udemy_fluttter/shared/news_cubit/news_state.dart';
import 'package:udemy_fluttter/shared/todo_cubit/cubit.dart';

class NewsHomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
     listener: (context,state){},
      builder: (context,state){
       var cubit=NewsCubit.get(context);
       return Scaffold(appBar:
       AppBar(title: Text(
           'NewsApp'
       ),
         actions: [IconButton(onPressed:()
         {
           navigateTo(context, SearchScreen());
         },
             icon: Icon(Icons.search)),
           IconButton(onPressed:(){
             TodoCubit.get(context).changeDarkMode();
           },
               icon: Icon(Icons.brightness_4_outlined)),
         ],
       ),
         body: cubit.screens[cubit.currentIndex],
         bottomNavigationBar: BottomNavigationBar(
           currentIndex: cubit.currentIndex,
           onTap: (index){
           cubit.changeNavBar(index);
           },
           items: cubit.bottomVBINewsList,
         ),
       );
      },
    );
  }
}
