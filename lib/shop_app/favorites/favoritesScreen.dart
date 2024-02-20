import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_app/homeModel.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import '../../shop_app_layout/cubit/shopLayoutCubit.dart';
import '../../shop_app_layout/cubit/shopLayoutStates.dart';

class favoritesScreen extends StatelessWidget {
  const favoritesScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit,shopStates>(
        listener: (context , state){
          if( state is shopSuccessChangeFavoritesState){
            if(!state.changeFavMod.status!)
              showToast(text: state.changeFavMod.message! ?? "unknown", state: toastStates.ERROR );
          }
        },
        builder: (context , state){
          shopCubit cubit = shopCubit.get(context);
          int number = 0;
          if(cubit.get_favorites != null && cubit.get_favorites!.data != null && cubit.get_favorites!.data!.data != null )
            number = cubit.get_favorites!.data!.data.length;
          return ConditionalBuilder(
            condition: state is! shopLoadingGetFavoritesState && number != 0, //simple reload
            builder: (context)=> ListView.separated(
               // physics: BouncingScrollPhysics(), // like refresh scrolling
                itemBuilder: (context , index) => buildListProduct(context , cubit.get_favorites!.data!.data[index].products!),
                separatorBuilder: (context , index) => myDivider(),
                itemCount: number
            ),
            fallback: (context)=> Center(child: CircularProgressIndicator(),),
          );
        }
      );
  }


}
