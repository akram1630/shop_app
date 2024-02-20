import 'package:dio/dio.dart';

class dioHelper{

  static Dio ? dio ;
  ///////////////////////////////////////////////////////////////
  static init(){
    dio = Dio(
        BaseOptions(
            baseUrl: 'https://student.valuxapps.com/api/',
            receiveDataWhenStatusError: true,
            /*headers: {
              'Content-Type': 'application/json',
              'lang': 'en'
            }*/
        )
    );
  }
  //////////////////////////////////////////////////////////
  static Future<Response>get({
    required String url, //sub url
    Map<String, dynamic> ? query ,
    String lang = 'ar',
    String ? token
  }) async
  {
    // we use headers here to do override when calling func
    dio!.options.headers = {  //override : dio.opt = Dio( base option : is done only when init but now like we add
      'lang' : lang,
      'Authorization' : token ?? '', // "If token is null, use an empty string ''
      'Content-Type' : 'application/json',
    };
    return  await dio!.get(url , queryParameters: query);
  }
  ///////////////////////////////////////////////////////////
  static Future<Response> post({ // future cuz the func includ .get() func
    required String url,
    required Map<String, dynamic> data, // the original
    Map<String, dynamic> ? query,
    String lang = 'en',
    String  ? token
  }) async
  {
    // we use headers here to do override when calling func
    dio!.options.headers = { // no overriding .headers == .add
      'lang' : lang,
      'Content-Type' : 'application/json',
      'Authorization' : token  ,
    };
    return  dio!.post(
        url ,
        queryParameters: query ,
        data: data // the original
    );
  }

}


void main(){
  dioHelper.init();
  /*
  dioHelper.post(
      url: 'login',
      data: {
        "email": "akram@gmail.com",
        "password": "123456"
      },
    lang: 'ar'
  ).then((value){
    print(value.data);
  }).catchError((err){
    print(err.toString());
  });
  */
  /*
  dioHelper.post(
      url: 'register',
      data: {
        'email' : 'touggourt@gmail.com' ,
        'name' : 'bendaikha' ,
        'phone' : '0554789745' ,
        'password' : '123456'
      }
  ).then((value){
    print(value.data);
  }).catchError((err){
    print(err.toString());
  });
  */
  /*
  dioHelper.get(
      url: 'categories', //constants
      lang: 'en'
    //token: token //not required in this get
  ).then((value){
    print(value.data);
  }).catchError((err){
    print(err.toString());
  });
  */
  /*
  dioHelper.get(
      url: 'home', //constants
      token: 'rlAVC3BTgZQY1q1JfMdRn3lts42mCUf7zyKZQJyZlQz7V2rCkBWkmfGTsNmOuDYxQrSXF1' ,//constants
      lang: 'en'
  ).then((value){
    print(value.data);
  }).catchError((err){
    print(err.toString());
  });
  */
  /*
  dioHelper.get( //get fav
    url: 'favorites',
    token: 'rlAVC3BTgZQY1q1JfMdRn3lts42mCUf7zyKZQJyZlQz7V2rCkBWkmfGTsNmOuDYxQrSXF1',
    lang: 'en',
  ).then((value){
    print(value.data);
  }).catchError((err){
    print(err.toString());
  });
  */
  /*
  dioHelper.post( //change fav
    url: 'favorites',
    data: {'product_id' : '56',},
    token: 'rlAVC3BTgZQY1q1JfMdRn3lts42mCUf7zyKZQJyZlQz7V2rCkBWkmfGTsNmOuDYxQrSXF1' ,
    lang: 'en',
  ).then((value){
    print(value.data);
  }).catchError((err){
    print(err.toString());
  });
  */
}