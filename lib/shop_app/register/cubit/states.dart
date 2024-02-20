
import '../../../models/shop_app/login_model.dart';

abstract class shopRegisterStates {}

class shopRegisterInitialStates extends shopRegisterStates {}

class shopRegisterLoadingStates extends shopRegisterStates {}

class shopRegisterSeccessStates extends shopRegisterStates {
  final shopAppLoginModel  loginModel;
  shopRegisterSeccessStates(this.loginModel);
}

class shopRegisterErrorStates extends shopRegisterStates {
  final String  error;
  shopRegisterErrorStates(this.error);
}

class shopRegisterChangePasswordVisibiltyStates extends shopRegisterStates{}
