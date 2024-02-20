
import '../../../models/shop_app/login_model.dart';

abstract class shopLoginStates {}

class shopLoginInitialStates extends shopLoginStates {}

class shopLoginLoadingStates extends shopLoginStates {}

class shopLoginSeccessStates extends shopLoginStates {
  final shopAppLoginModel loginModel;
  shopLoginSeccessStates(this.loginModel);
}

class shopLoginErrorStates extends shopLoginStates {
  final String error;
  shopLoginErrorStates(this.error);
}

class shopLoginChangePasswordVisibiltyStates extends shopLoginStates{}
