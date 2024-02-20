
// i created this code by my self instead of using json to dart webSite like the course did
import 'homeModel.dart';

class getFavorites {
  bool ? status ;
  favData ?data ;
  getFavorites.fromJson({required Map<String , dynamic> json}){
    status = json['status'];
    if(json['data'] != null)
      data = favData.fromJson(json: json['data']);
  }
}
class favData{
  int ? currentPage ;
  List<dataFav> data = [] ;
  favData.fromJson({required Map<String , dynamic> json}){
    currentPage = json['current_page'];
    if(json['data'] != null)
      json['data'].forEach((element){
        data.add( dataFav.fromJson(json: element) );
      });
  }
}
class dataFav {
  int ? id;
  productModel ? products;
  dataFav.fromJson({required Map<String , dynamic> json}){
    id = json['id'];
    if(json['product'] != null)
      products = productModel.fromJson(json: json['product']);
  }
}

