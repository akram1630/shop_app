import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/components/components.dart';
import '../shop_app/search/searchScreen.dart';
import 'cubit/shopLayoutCubit.dart';
import 'cubit/shopLayoutStates.dart';

class shopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit , shopStates>(
      listener: (context , shopStates state){},
      builder: (BuildContext context , state){
        shopCubit cubit = shopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
              title: Text('SALLA') ,
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, searchScreen());
                  },
                  icon : Icon(Icons.search)
              ),

            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (indexOfBottom){
              cubit.changeBottom(indexOfBottom);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ],
          ),
        );
      },

    );
  }
}


/*
 TextButton(
            child: Text('SIGN OUT'),
            onPressed: (){
              sighOut(context);
            },
          )
*/