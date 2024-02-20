import 'package:shop_app/models/shop_app/homeModel.dart';
// i created this code by my self instead of using json to dart webSite like the course did
class searchModel {
  bool ? status ;
  searchData ? data ;

  searchModel.fromJson({required Map<String , dynamic> json}){
    status = json['status'];
    if(json['data'] != null)
      data = searchData.fromJson(json: json['data']);
  }
}
class searchData{
  int ? currentPage ;
  List<searchProd> data = [] ;
  searchData.fromJson({required Map<String , dynamic> json}){
    currentPage = json['current_page'];
    if(json['data'] != null)
      json['data'].forEach((element){
        data.add( searchProd.fromJson(json: element) );
      });
  }
}

class searchProd{
  int ?id ;
  dynamic price ;
  String ? image;
  String ? name;
  String ? description ;
  bool ? inFavorites ;
  bool ? inCart ;
  searchProd.fromJson({required Map<String , dynamic> json}){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}