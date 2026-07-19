import 'package:flutter_application_1/cupitstate/states.dart';
import 'package:flutter_application_1/service/fetch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cupitclass extends Cubit<states> {
  Cupitclass():super(intialfetch());
  List <dynamic> news=[];
   void feettch ({required String catugary})async{
    emit(loadingfetch());
    try{
    fetcch f=fetcch(catugary);
    news=await f.fetchnews();
    emit(sucssfulfetch());
    }
    catch(e){
      emit(erorrfetch());
    }


  }

  }
  