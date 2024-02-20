import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shop_app/search/cubit/states.dart';


import '../../../../shared/network/end_points.dart';
import '../../../models/shop_app/searchModel.dart';
import '../../../shared/components/constants.dart';

class shopSearchCubit extends Cubit<searchStates>{
  shopSearchCubit() : super(searchInitialState());
  static shopSearchCubit get(context){
    return BlocProvider.of(context);
  }

  searchModel ? model ;
  void search({required String text}){
    emit(searchLoadingState());
    dioHelper.postDataForShopApp(url: SEARCH_PRODUCT, data: { 'text' : text} , token: token)
        .then((value){
          model = searchModel.fromJson(json: value.data);
          print(value.data);
          emit(searchSuccessState());
    }).catchError((err){
      print(err.toString());
      emit(searchErrorState());
    });
  }
}