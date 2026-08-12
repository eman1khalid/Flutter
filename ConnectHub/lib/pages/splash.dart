
import 'package:ConnectHub/globalvariable.dart';
import 'package:ConnectHub/navigationbar.dart';
import 'package:ConnectHub/pages/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initStategit status
    super.initState();
    Future.delayed(Duration(seconds: 5),()async{
      var user=FirebaseAuth.instance.currentUser;
      if(user!=null){
        DocumentSnapshot snapshot=await FirebaseFirestore.instance.collection("users").doc(userid).get();
    if(snapshot.exists)
    {var data=snapshot.data() as Map<String,dynamic>;
    username=data["name"];
    imageuser=data["imagrurl"];
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context){return navbar();}));}
      else{
       Navigator.pushReplacement(context, MaterialPageRoute(builder:(context){return Login();}));
      }
     
      
    }});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Image.asset("assets/images/logoapp.png" ,width: 700,),
           SizedBox(height: 50, ),
           LinearProgressIndicator(color: const Color.fromARGB(255, 105, 64, 255),)
          
        ],
        ),
      )
      
    );
  }
}