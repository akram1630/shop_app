class categoriesModel{

  bool ? status ;
  categoriesDataModel ? data ;
  categoriesModel.fromJson({required Map<String,dynamic>  json}){
    status = json['status'];
    /////////////////////always and always and always null check in APIs
    data = json['data'] != null ? categoriesDataModel.fromJson(json: json['data']) : null;
  }

}

class categoriesDataModel{
  int ? currentPage ;
  List<dataModel>  data =[] ; // [] for .add //list of categories
  categoriesDataModel.fromJson({required Map<String,dynamic>  json}){
    currentPage = json['current_page'];
    if (json['data'] != null) { /////////////////////always and always and always null check in APIs
      json['data'].forEach((element) {
        data.add(dataModel.fromJson(json: element));
      });
    }
  }
}

class dataModel{
  int ? id ;
  String ? name;
  String ? image ;
  dataModel.fromJson({required Map<String,dynamic>  json}){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}