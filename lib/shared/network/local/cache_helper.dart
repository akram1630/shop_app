import 'package:shared_preferences/shared_preferences.dart';
// sharedPreferencrs is like mini database
// we stock mini data like boolean (darkMode)
class cachHelper {

  static SharedPreferences ? sharedPreferences ;

  static init()async{ // it should be called in main()
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool>  putBoolean({required String key , required bool value}) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic  get({required String key})  { // works on all apps even shopApp
    return  sharedPreferences!.get(key);
  }
/////////////////////////////////////////////////////////////////shopAPP

  static Future<bool> saveData({ // save all data type in this func
    required String key ,
    required dynamic value
  }) async{
    if(value is int) return await sharedPreferences!.setInt(key, value);
    if(value is double) return await sharedPreferences!.setDouble(key, value);
    if(value is bool) return await sharedPreferences!.setBool(key, value);
    return await sharedPreferences!.setString(key, value);
  }

  static Future<bool> removeData({required String key})async{
    return await sharedPreferences!.remove(key);
  }

}