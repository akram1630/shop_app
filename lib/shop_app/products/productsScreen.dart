import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_app/categoriesModel.dart';
import '../../models/shop_app/homeModel.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../../shop_app_layout/cubit/shopLayoutCubit.dart';
import '../../shop_app_layout/cubit/shopLayoutStates.dart';

class productsScreen extends StatelessWidget {
  const productsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit,shopStates>(
      listener: (context , state){
        if( state is shopSuccessChangeFavoritesState){
          if(!state.changeFavMod.status!) //if false
            showToast(text: state.changeFavMod.message!, state: toastStates.ERROR);
        }
      },
      builder: (context , state){
        shopCubit cubit = shopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.home_model !=null && cubit.categories_model !=null  ,
          builder: (context)=> builderWidget(cubit.home_model! , cubit.categories_model! , context),
          fallback: (context)=> Center(
            child: CircularProgressIndicator(),
          ) ,
        );
      },
    );
  }

  Widget builderWidget(homeModel home_model , categoriesModel categ_model , context){
    return SingleChildScrollView( // doesn't accept any Expanded inside it
      physics: BouncingScrollPhysics(), // when we try to refresh : the content will be flexble
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //banners :
          CarouselSlider(
              items: home_model.data!.banners.map(
                      (e) => Image(
                          image: NetworkImage(e.image!),
                        width: double.infinity,
                        fit: BoxFit.cover, // to fix resolution
                      )
              ).toList(), // items demands a List
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1.0, // 1== image will take all the place //0.5== image will take half
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false , // the direction of auto scrolling,
                autoPlay: true,
                autoPlayInterval: Duration( //showing image time
                  seconds: 3
                ),
                autoPlayAnimationDuration: Duration( // animation time when it changes auto
                  seconds: 1
                ),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal
              )
          ),
          SizedBox(height: 20,),
          //categories :
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height : 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal, // scrolling horoz
                      // shrinkWrap: true ,// not important here
                      physics: BouncingScrollPhysics(), // like refresh scrolling
                      itemBuilder: (context , index) => buildCategoryItem(categ_model.data!.data[index] , context),
                      separatorBuilder: (context , index) => SizedBox(width: 10,),
                      itemCount: categ_model.data!.data.length
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('New Products',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(// its resolution works on all screens without error // can also be in galerie app
               physics: NeverScrollableScrollPhysics(), // desactivate scrolling from GridView scrolling to scrol from the first singleScrollChild
               shrinkWrap: true, // make products able to scroll not from GridView
               mainAxisSpacing: 3, //padding hori
               crossAxisSpacing: 3,//padding verti
               childAspectRatio: 1 / 1.67, // size padding hori
               crossAxisCount: 2, // number of colums of products
               children: List.generate( home_model.data!.products.length ,
                      (index) => buildGridProduct(home_model.data!.products[index] , context)
              )
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategoryItem(dataModel model , context)=> Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image!),
        fit: BoxFit.cover, // make it big & fixed
        height: 100,
        width: 110,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 110,
        child: Text(
          model.name!,
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      )
    ],
  );
  Widget buildGridProduct(productModel model , context){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:[
              Image(
                image: NetworkImage(model.image!) ,
              width: double.infinity,
              height: 200,
              //fit: BoxFit.cover, //fix resolution to fill all
            ),
              if(model.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white
                  ),
                ),
              )
            ]
          ),
          Padding(
            padding:  EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3 // like sizedBox among Lines
                  ),
                ),
                Row(
                  children: [
                    Text('${model.price!.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          color: defaultColor
                      ),
                    ),
                    SizedBox(width: 5,),
                    if(model.discount != 0)
                      Text('${model.old_price!.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough // line on old price
                        ),
                      ),
                    Spacer(), // max sizedBox
                    IconButton(
                        onPressed: (){
                          shopCubit.get(context).changeFavorites(productId: model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:  shopCubit.get(context).favorites[model.id]! ? defaultColor: Colors.grey ,
                          child: Icon(
                            Icons.favorite_border ,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                       // padding: EdgeInsets.zero , //no padding
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

