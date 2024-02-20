import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor, // colors of indicator
    //backgroundColor: Colors.deepOrange, //course
    scaffoldBackgroundColor: HexColor('333739'), // the second principal
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        color: HexColor('333739'),
        titleTextStyle: TextStyle(
          fontFamily: 'Jannah',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
        ),
        elevation: 0.0,
        backwardsCompatibility: false, // lazm false the root to control (statusBar) the screen which show the time and battery ....
        systemOverlayStyle: SystemUiOverlayStyle( //control (statusBar) the screen which show the time and battery...
            statusBarColor: HexColor('333739'),  // background color
            statusBarIconBrightness: Brightness.light // contenent color time letters ...
        ) ,
        iconTheme: IconThemeData(
            color: Colors.white

        )
    ),
    //primarySwatch: Colors.deepOrange, //color of circular loading

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333739'),
      elevation: 20,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'Jannah' // style in assets and yaml
        ),
        subtitle1: TextStyle(
            fontSize: 14,
            height: 1.3, // padding ta9arob
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'Jannah' // style in assets and yaml
        )
    )
);

ThemeData lightTheme = ThemeData( // all the whole app will take this parameter if we dont change
  primarySwatch: defaultColor, // colors of indicator
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      color: Colors.white,
      titleTextStyle: TextStyle(
        fontFamily: 'Jannah',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
      ),
      elevation: 0.0,
      backwardsCompatibility: false, // lazm false the root to control (statusBar) the screen which show the time and battery ....
      systemOverlayStyle: SystemUiOverlayStyle( //control (statusBar) the screen which show the time and battery...
          statusBarColor: Colors.white,  // background color
          statusBarIconBrightness: Brightness.dark // contenent color time letters ...
      ) ,
      iconTheme: IconThemeData(
          color: Colors.black
      )
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        fontFamily: 'Jannah'   // style in assets and yaml
      ),
      subtitle1: TextStyle(
        height: 1.3, // padding ta9arob
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'Jannah' // style in assets and yaml
      )
  ),
  //primarySwatch: Colors.deepOrange, //color of circular loading
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    backgroundColor: Colors.white,
    elevation: 20,
  ),
);