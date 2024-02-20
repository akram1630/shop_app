import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shop_app_layout/cubit/shopLayoutStates.dart';

import '../../models/shop_app/categoriesModel.dart';
import '../../models/shop_app/changeFavoritesModel.dart';
import '../../models/shop_app/getFavorites.dart';
import '../../models/shop_app/homeModel.dart';
import '../../models/shop_app/login_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';
import '../../shop_app/categories/categoriesScreen.dart';
import '../../shop_app/favorites/favoritesScreen.dart';
import '../../shop_app/products/productsScreen.dart';
import '../../shop_app/settings/settingsScreenShop.dart';


class shopCubit extends Cubit<shopStates>{
  shopCubit() : super(shopInitialState());
  static shopCubit get(context) => BlocProvider.of(context) ;
  ///////////////////////////////////////////////////////////
  int currentIndex = 0 ;
  List<Widget> bottomScreens = [
    productsScreen() , categoriesScreen() ,
    favoritesScreen() , settingsScreenShop()
  ];
  void changeBottom(int index){
    currentIndex = index ;
    emit(shopChangeBottomNavState());
  }
//////////////////////////////////////////////////////////////////
  homeModel ? home_model ;
  Map<int , bool>  favorites = {} ; // to let us .add <id , bool>
  void getHomeData(){
    emit(shopLoadingHomeDataState()); // to make user wait
    dioHelper.getDataForShopApp(
        url: HOME, //constants
        token: token ,//constants
        lang: 'en'
    ).then((value){
      home_model = homeModel.fromJson(json: value.data);
      //print(home_model!.status);

      home_model!.data!.products.forEach((element) {
        favorites.addAll({element.id! : element.inFavorites!});
      });
      print(favorites.toString());

      printFullText(home_model!.data!.banners[0].image!);
      emit(shopSuccessHomeDataState());
    }).catchError((err){
      print(err.toString());
      emit(shopErrorHomeDataState());
    });
  }

  categoriesModel ? categories_model ;
  void getCategories(){
    dioHelper.getDataForShopApp(
        url: GET_CATEGORIES, //constants
      lang: 'en'
        //token: token //not required in this get
    ).then((value){

      categories_model = categoriesModel.fromJson(json: value.data);
      print(categories_model!.status);
      emit(shopSuccessCategoriesState());
    }).catchError((err){
      print(err.toString());
      emit(shopErrorCategoriesState());
    });
  }

  changeFavoritesModel ? change_fav_model ;
  changeFavorites({required int productId}){
    favorites[productId] = !favorites[productId]! ;
    emit(shopSuccessChangeFavoritesImmediatelyState()); // to refresh immediately
    dioHelper.postDataForShopApp(
        url: FAVORITES,
        data: {'product_id' : productId,},
        token: token,
        lang: 'en',
    ).then((value){
      change_fav_model = changeFavoritesModel.fromJson(json: value.data);
      // if server downs
      if(!change_fav_model!.status! ){
        favorites[productId] = !favorites[productId]! ;
      }else{
        getFavProduct();
      }
      print(value.data);
      emit(shopSuccessChangeFavoritesState(change_fav_model!));
    }).catchError((error){
      favorites[productId] = !favorites[productId]! ;
      emit(shopErrorChangeFavoritesState());
    });
  }



  getFavorites ? get_favorites ;
  void getFavProduct(){
    emit(shopLoadingGetFavoritesState());
    dioHelper.getDataForShopApp(
        url: GET_FAV,
        token: token,
        lang: 'en',
    ).then((value){
      get_favorites = getFavorites.fromJson(json: value.data);
      //print('geeeet :');
     // print(value.data);
      emit(shopSuccessGetFavoritesState());
    }).catchError((err){
      emit(shopErrorGetFavoritesState());
    });
  }

  shopAppLoginModel ? get_login_data ;
  void getLoginData(){
    emit(shopLoadingGetLoginDataState());
    // this should be called in main blocProvider.. or it won't work :
    //that's why i added it here cause getLoginDate is called in main blocProvider..
    emit(shopLoadingUpdateUserDataState());

    dioHelper.getDataForShopApp(
      url: PROFILE,
      token: token,
      lang: 'en',
    ).then((value){
      get_login_data = shopAppLoginModel.fromJson(value.data);
      printFullText(get_login_data!.data!.name!);
      emit(shopSuccessGetLoginDataState(get_login_data!));
    }).catchError((err){
      emit(shopErrorGetLoginDataState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
  }){

    emit(shopLoadingUpdateUserDataState()); // it's also on getLoginData();
    dioHelper.putDataForShopApp(
      url: UPDATE_PROFILE,
      data: {
        'name' : name,
        'phone' : phone,
        'email' : email,
      },
      token: token,
      lang: 'ar',
    ).then((value){

      get_login_data = shopAppLoginModel.fromJson(value.data);
      //print(value.data);
      emit(shopSuccessUpdateUserDataState(get_login_data!));
    }).catchError((err){
      emit(shopErrorUpdateUserDataState());
    });
  }


  /*******************************OWENED BY NEWS APP***************************/
  bool  isDark = false;
  void changeAppMode({ bool ? fromShared}) async{

    if(fromShared != null){
      isDark = fromShared;
      emit(shopChangeModeState());
    }
    else{
      isDark = !isDark;
      cachHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(shopChangeModeState());
      });
    }

  }

}