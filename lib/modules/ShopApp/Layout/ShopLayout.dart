import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/modules/ShopApp/Login/ShopLoginScreen.dart';
import 'package:udemy_fluttter/modules/ShopApp/Search/searchScreen.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopCubit/shopCubit.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopCubit/shopState.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/shared/network/local/cash_helper.dart';

class ShopLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state){},
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(
            title: Text(
                'Salla'
            ),
            actions: [
              IconButton(onPressed:(){
                navigateTo(context, SearchScreen());
              },
                icon:Icon(Icons.search),),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon:Icon(Icons.home),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon:Icon(Icons.apps),
                  label: 'Categories'),
              BottomNavigationBarItem(
                  icon:Icon(Icons.favorite),
                  label: 'favorites'),
              BottomNavigationBarItem(
                  icon:Icon(Icons.settings),
                  label: 'Settings'),
            ],

          ),
        );
      },

    );
  }
}
