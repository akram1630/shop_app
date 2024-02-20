class shopAppLoginModel{
  bool ? status ;
  String ? message ;
  userData ? data ; //cuz it's map

  shopAppLoginModel.fromJson(Map<String , dynamic> json){
    status = json['status'] ;
    message = json['message'] ;
    /////////////////////////////////// cuz (data : null) if email and pass are false
    data = json['data'] != null ? userData.fromJson(json['data']) : null ;

  }

}
///// secondary class
class userData{

  int ? id ;
  String ? name ;
  String ?  email ;
  String ? phone ;
  String ? image ;
  int ? points ;
  int ? credit ;
  String ? token ;

  //named constructor
  userData.fromJson(Map<String , dynamic> json){
    id = json['id'] ;
    name = json['name'] ;
    email = json['email'] ;
    phone = json['phone'] ;
    image = json['image'] ;
    points = json['points'] ;
    credit = json['credit'] ;
    token = json['token'] ;
  }

}