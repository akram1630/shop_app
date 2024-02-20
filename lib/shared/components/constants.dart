import 'package:shop_app/shop_app/login/shopLoginScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void sighOut(context){
  cachHelper.removeData(key: 'token').then((value) {
    if(value) //Future<bool> return type
      navigateAndFinish(context, shopLoginScreen());
  });
}

void printFullText(String text){ // to print all contenent in consol running
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}

String ? token = '' ;
//////////////////////////social//////////////////////////
String ? uId = '';