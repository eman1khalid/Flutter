
import 'package:ConnectHub/pages/auth/login.dart';
import 'package:ConnectHub/pages/homepage.dart';
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
    Future.delayed(Duration(seconds: 5),(){
      var user=FirebaseAuth.instance.currentUser;
      if(user==null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context){return Login();}));}
      else{
       Navigator.pushReplacement(context, MaterialPageRoute(builder:(context){return Homepage();}));
      }
     
      
    });
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