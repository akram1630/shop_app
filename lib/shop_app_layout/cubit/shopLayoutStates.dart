

import '../../models/shop_app/changeFavoritesModel.dart';
import '../../models/shop_app/login_model.dart';

abstract class shopStates{}

class shopInitialState extends shopStates{}

class shopChangeBottomNavState extends shopStates{}

class shopLoadingHomeDataState extends shopStates{}

class shopSuccessHomeDataState extends shopStates{}

class shopErrorHomeDataState extends shopStates{}

class shopSuccessCategoriesState extends shopStates{}

class shopErrorCategoriesState extends shopStates{}

class shopSuccessChangeFavoritesImmediatelyState extends shopStates{}

class shopSuccessChangeFavoritesState extends shopStates{
  final changeFavoritesModel changeFavMod ;
  shopSuccessChangeFavoritesState(this.changeFavMod);
}


class shopErrorChangeFavoritesState extends shopStates{}

class shopSuccessGetFavoritesState extends shopStates{}

class shopLoadingGetFavoritesState extends shopStates{}

class shopErrorGetFavoritesState extends shopStates{}

class shopSuccessGetLoginDataState extends shopStates{
  final shopAppLoginModel model ;
  shopSuccessGetLoginDataState(this.model);
}

class shopErrorGetLoginDataState extends shopStates{}

class shopLoadingGetLoginDataState extends shopStates{}

class shopLoadingUpdateUserDataState extends shopStates{}

class shopSuccessUpdateUserDataState extends shopStates{
  final shopAppLoginModel model ; // the message request will be the same of login
  shopSuccessUpdateUserDataState(this.model);
}

class shopErrorUpdateUserDataState extends shopStates{}



class shopChangeModeState extends shopStates{}

