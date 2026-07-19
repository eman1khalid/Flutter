import 'package:app2/cupitstate/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class cubitclass extends Cubit<States>{
  cubitclass():super(initialState());
   Future<void>login(String email,String password)async {
    emit(lodinglogin());
    try{
    final user =await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    emit(sucssfullogin());
    }catch(e){
    emit(errorlogin());
    }}
    Future<void>reg(String email,String password)async {
    emit(lodingreg());
    try{
    final user =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    emit(sucssfulreg());
    }catch(e){
      print(e.toString());
    emit(errorreg());
    }}
    Future<void>logout()async {
    emit(lodinglogout());
    try{
    final user =await FirebaseAuth.instance.signOut();
    emit(sucssfullogout());
    }catch(e){
    emit(errorlogout());
    }}
      Future<void>delet()async {
    emit(lodingdelet());
    try{
    final user =await FirebaseAuth.instance.currentUser?.delete();
    emit(sucssfuldelet());
    }catch(e){
    emit(errordelet());
    }}
    }
