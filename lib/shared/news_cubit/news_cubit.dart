import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/modules/SettingsScreen/Settings_screen.dart';
import 'package:udemy_fluttter/modules/business/business_screen.dart';
import 'package:udemy_fluttter/modules/science/science_screen.dart';
import 'package:udemy_fluttter/modules/sports/sports_screen.dart';
import 'package:udemy_fluttter/shared/network/remote/dio_helper.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit(NewsStates initialState) : super(initialState);
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
List<BottomNavigationBarItem> bottomVBINewsList=
        [
           BottomNavigationBarItem(icon:Icon(
       Icons.business_sharp)
       ,label: 'Business'),
          BottomNavigationBarItem(icon:Icon(
              Icons.sports)
              ,label: 'Sports'),
          BottomNavigationBarItem(icon:Icon(
              Icons.science)
              ,label: 'Science'),
        ];
 List<Widget>screens=[
   BusinessScreen(),
   SportsScreen(),
   ScienceScreen(),

 ];
  List<dynamic> business=[];
  List<dynamic> sports=[];
  List<dynamic> science=[];
  List<dynamic> search=[];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        path: 'v2/top-headlines',
        query:{'country':'eg',
          'category':'business',
          'apikey':'1fa8a8274fd94f14badadf38da9dd335'
        }).then((value) {
      business=value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
     print(error.toString());
     emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports(){
    emit(NewsGetSportsLoadingState());
   DioHelper.getData(
        path: 'v2/top-headlines',
        query:{'country':'eg',
          'category':'sports',
          'apikey':'1fa8a8274fd94f14badadf38da9dd335'
        }).then((value) {
      sports=value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });}

  void getScience(){
    emit(NewsGetScienceLoadingState());

      DioHelper.getData(
          path: 'v2/top-headlines',
          query:{'country':'eg',
            'category':'science',
            'apikey':'1fa8a8274fd94f14badadf38da9dd335'
          }).then((value) {
        science=value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
  }

  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        path: 'v2/everything',
        query:{
          'q':'$value',
          'apikey':'1fa8a8274fd94f14badadf38da9dd335'
        }).then((value) {
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  void changeNavBar(int index){
    currentIndex=index;
    // if(index==1){
    //   getSports();
    // }
    // if(index==2){
    //   getScience();
    // }
        emit(NewsBottomNav());
       }

}