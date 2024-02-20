import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/login/cubit/states.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class shopLoginCubit extends Cubit<shopLoginStates>{
  shopLoginCubit() : super(shopLoginInitialStates());
  
  static shopLoginCubit get(BuildContext context){
    return BlocProvider.of(context);
  }
  shopAppLoginModel ? loginModel ;

  void userLogin ({
    required String email ,
    required String password ,
  }){
    emit(shopLoginLoadingStates()); // to scroll for 2 second with consitionalBuilder help
    dioHelper.postDataForShopApp(
        url: LOGIN ,
        data: {
          'email' : email ,
          'password' : password
        }
    ).then((value ){
      if (value.data != null) {
        loginModel = shopAppLoginModel.fromJson(value.data!);
        emit(shopLoginSeccessStates(loginModel!)); //go to bloc obvioser
      }else{
        emit(shopLoginErrorStates("Invalid response data"));
      }

    }).catchError((error){
      print('----\n${error.toString()}--\n');
      emit(shopLoginErrorStates(error.toString()));
    });
  }

  IconData suffixEyePass = Icons.visibility_outlined ;
  bool isPassword = true;
  void changePassVisibility(){
    isPassword  = !isPassword;
    suffixEyePass =
    isPassword ?  Icons.visibility_off_outlined : Icons.visibility_outlined ;
    emit(shopLoginChangePasswordVisibiltyStates());
  }
}