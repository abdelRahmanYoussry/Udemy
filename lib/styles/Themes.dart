import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData lightTheme=  ThemeData(
    primarySwatch:defaultColor ,
    scaffoldBackgroundColor:Colors.white ,
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      systemOverlayStyle:SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      ) ,
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'jannah',
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
    ),
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        elevation:40
    ),
    textTheme:TextTheme(
        bodyText1: TextStyle(
          fontFamily:'jannah' ,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),
        subtitle1:TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
         height: 1.3
    )
    ),
    fontFamily: 'jannah'
);

ThemeData darkTheme=  ThemeData(
    primarySwatch:defaultColor ,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        systemOverlayStyle:SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarIconBrightness: Brightness.light
        ) ,
        color:HexColor('333739'),
        elevation: 0,
        titleTextStyle: TextStyle(
            fontFamily: 'jannah',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
        iconTheme: IconThemeData(
            color: Colors.white
        )
    ),
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: HexColor('333739'),
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      elevation:40,
    ),
    textTheme:TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'jannah',
        ),
        subtitle1:TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1.3
    )
    ),
    fontFamily: 'jannah'
);
