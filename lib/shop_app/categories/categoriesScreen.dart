import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/shop_app/categoriesModel.dart';
import '../../shared/components/components.dart';
import '../../shop_app_layout/cubit/shopLayoutCubit.dart';
import '../../shop_app_layout/cubit/shopLayoutStates.dart';


class categoriesScreen extends StatelessWidget {
  const categoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit , shopStates>(
        listener: (context , state){},
        builder: (context , state){
          shopCubit cubit = shopCubit.get(context);
          //no scafflod cuz it's a sub page
          if(cubit.categories_model != null
              &&  cubit.categories_model!.data != null
          ) // to solve null check value
          return ListView.separated(
              itemBuilder: (context , index) => buildCatItem(cubit.categories_model!.data!.data[index]),
              separatorBuilder: (context , index) => myDivider(),
              itemCount: cubit.categories_model!.data!.data.length
          );
          else return CircularProgressIndicator();
    },
    );
  }
  Widget buildCatItem(dataModel model){
    return Padding(
        padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Image(
              image: NetworkImage(model.image ?? 'vide'),
              width: 80,
              height: 80,
              fit: BoxFit.cover, // to zoom picture to fill width & height
          ),
          SizedBox(width: 20,),
          Text(model.name ?? 'vide',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ) ,
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
