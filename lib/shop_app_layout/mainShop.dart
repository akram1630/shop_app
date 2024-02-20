import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shop_app_layout/shop_layout.dart';

import '../../shared/components/constants.dart';
import '../shared/bloc_observer.dart';
import '../shared/styles/themes.dart';
import '../shop_app/login/shopLoginScreen.dart';
import '../shop_app/on_boarding/onBoardingScreen.dart';
import 'cubit/shopLayoutCubit.dart';
import 'cubit/shopLayoutStates.dart';

void main()async{    //// the main for running
  //runApp(MyApp());
  /*----------------OR-------------------*/
  //Widget appRev = MyApp();
  WidgetsFlutterBinding.ensureInitialized(); // to make sure that all lines complete theie execution befor runApp();
  Bloc.observer = MyBlocObserver(); // to print the the actual state & updates
  dioHelper.init(); // call the init of APIs dio http
  await cachHelper.init(); // call the init of shared pref
  bool ? isDark = cachHelper.get(key: 'isDark');
  bool ? onBoarding = cachHelper.get(key: 'onBoarding');
  token = cachHelper.get(key: 'token'); // token is constants components
  print('------------------> token : $token');
  //printFullText(token!);
  //print('the onBoarding is : $onBoarding');
  Widget ? widget ;
  if(onBoarding != null){  // (onBoarding! != null)Null check operator used on a null value
    if(onBoarding){
      if(token != null)
        widget = shopLayout();
      else
        widget = shopLoginScreen();
    }
  }
  else{
    widget = onBoardingScreen();
  }


  MyApp appRev = MyApp(isDark: false, startWidget: widget!); /////////////////////////////ALWAYSLIGHT///////////////////
  runApp(appRev);  // funtion runApp
}

/**************************************************************************************/

class MyApp extends StatelessWidget { /// class that wil be executed in void main
  //constuctor build

  MyApp({this.isDark,required this.startWidget});
  final bool  ? isDark;
  final Widget ? startWidget ;
  @override
  Widget build(BuildContext context){
    return
      //MultiBlocProvider(     //////////////////// the bloc build only when running
      //providers: [
        //BlocProvider(
          //create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
        //),

        BlocProvider(
          create: (context) => shopCubit()..getHomeData()..getCategories()
            ..getFavProduct()..getLoginData()//..changeAppMode(fromShared: isDark),
        //),
     // ],
      ,child: BlocConsumer<shopCubit ,shopStates>(
          listener: (context,state){},
          builder:  (context,state){
            shopCubit cubit = shopCubit.get(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false, // remove red widget
              //theme is overriding in normal theme and dark theme
              theme: lightTheme,  // lightTheme : is a variable i have created
              darkTheme: darkTheme, // darkTheme : is a variable i have created
              themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light, // the principal
              home: startWidget
            );
          }
      ),
    );
  }
}