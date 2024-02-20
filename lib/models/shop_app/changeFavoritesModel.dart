class changeFavoritesModel{
  bool ? status ;
  String ? message ;

  changeFavoritesModel.fromJson({required Map<String , dynamic> json}){
    status = json['status'];
    message = json['message'];
  }
}