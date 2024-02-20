class homeModel {
  bool ? status;
  //String message because always null
  homeDataModel ? data ;
  homeModel.fromJson({required Map<String , dynamic> json}){
    status = json['status'];
    data = homeDataModel.fromJson(json: json['data']);
  }
}

class homeDataModel{
  List<bannerModel> banners = [] ; //list in api //to let us add []
  List<productModel> products = [];//list in api //to let us add []
  homeDataModel.fromJson({required Map<String , dynamic> json}){
    json['banners'].forEach((element){
      banners.add(bannerModel.fromJson(json: element));
    });
    json['products'].forEach((element){
      products.add(productModel.fromJson(json: element));
    });
  }
}

class bannerModel{
  int ? id;
  String ? image ;
  bannerModel.fromJson({required Map<String , dynamic> json}){
    id = json['id'];
    image = json['image'];
  }
}
class productModel{
  int ?id ;
  dynamic price ;
  dynamic old_price ; // when we don't know the type
  dynamic discount ;
  String ? image;
  String ? name;
  bool ? inFavorites ;
  bool ? inCart ;
  productModel.fromJson({required Map<String , dynamic> json}){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}