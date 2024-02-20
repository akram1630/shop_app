import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shop_app/register/cubit/states.dart';


import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/end_points.dart';

class shopRegisterCubit extends Cubit<shopRegisterStates>{
  shopRegisterCubit() : super(shopRegisterInitialStates());
  
  static shopRegisterCubit get(BuildContext context){
    return BlocProvider.of(context);
  }
  shopAppLoginModel ? loginModel ;
  void userRegister ({
    required String email ,
    required String password ,
    required String name ,
    required String phone ,
}){
    emit(shopRegisterLoadingStates()); // to scroll for 2 second with consitionalBuilder help
    dioHelper.postDataForShopApp(
        url: REGISTER,
        data: {
          'email' : email ,
          'name' : name ,
          'phone' : phone ,
          'password' : password
        }
    ).then((value){
      //print('==========>${value.data['message']}');
      //print(value.data);
      loginModel = shopAppLoginModel.fromJson(value.data);
      //print(loginModel!.status);
      //print(loginModel!.message);
      //print(loginModel!.data!.token);
      emit(shopRegisterSeccessStates(loginModel!));
    }).catchError((error){
      print('\n${error.toString()}\n');
      emit(shopRegisterErrorStates(error.toString()));
    });
  }

  IconData suffixEyePass = Icons.visibility_outlined ;
  bool isPassword = true;
  void changePassVisibility(){
    isPassword  = !isPassword;
    suffixEyePass = isPassword ?  Icons.visibility_off_outlined : Icons.visibility_outlined ;
    emit(shopRegisterChangePasswordVisibiltyStates());
  }
}