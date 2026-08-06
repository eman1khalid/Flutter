import 'package:dio/dio.dart';

class fetcch{
  String cat;
  fetcch(this.cat);
  Dio dio=Dio();
  
  Future <List<dynamic>> fetchnews ()async{
    try{
    Response x= await dio.get("https://newsapi.org/v2/everything",queryParameters: {"q":cat,"apiKey":"7d64adce474640b7bdc72f07ad831261"});
    return x.data["articles"];}catch(e){
      return [];
    }

  }
}