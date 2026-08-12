import 'package:ConnectHub/cupitstate/auth/statesauth.dart';
import 'package:ConnectHub/globalvariable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class cubitclass extends Cubit<States>{
  cubitclass():super(initialState());

   Future<void>login(String email,String password)async {
    emit(lodinglogin());
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    print("uid ${userid}");
    DocumentSnapshot snapshot=await FirebaseFirestore.instance.collection("users").doc(userid).get();
    if(snapshot.exists)
    {var data=snapshot.data() as Map<String,dynamic>;
    username=data["name"];
    imageuser=data["imagrurl"];
    print("username ${username}");
    print("image url ${imageuser}");
    }

    emit(sucssfullogin());
    }catch(e){
    emit(errorlogin());
    }}
    Future<void>reg({required String email,required String password,required String name,String? urlimg})async {
    emit(lodingreg());
    try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    String uid=userid!;
    username=name;
    imageuser=urlimg;
    await FirebaseFirestore.instance.collection("users").doc(userid).set(
      {"uid":uid,
      "name":name,
      "email":email,
      "imagrurl":urlimg}
    );

    emit(sucssfulreg());
    }catch(e){
      print(e.toString());
    emit(errorreg());
    }}
    Future<void>logout()async {
    emit(lodinglogout());
    try{
    await FirebaseAuth.instance.signOut();
    username=null;
    imageuser=null;
    emit(sucssfullogout());
    }catch(e){
    emit(errorlogout());
    }}
      Future<void>delet()async {
    emit(lodingdelet());
    try{
    String? uid=userid;
    await FirebaseFirestore.instance.collection("users").doc(uid).delete();
    await FirebaseAuth.instance.currentUser?.delete();

    emit(sucssfuldelet());
    }catch(e){
      
    emit(errordelet());
    }}
    
    Future<void>Forgetpassword(String email)async {
    emit(loadingforg());
    try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    emit(sucssforg());
    }catch(e){
    emit(errorforg());
    }}
     Future <void> uodateuser({required String? name, required String? image})async{
    await FirebaseFirestore.instance.collection("users")
    .doc(userid)
    .update({
      "name": name,
      "imagrurl": image,
      
       
    });}
}
