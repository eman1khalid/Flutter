import 'package:ConnectHub/cupitstate/auth/cupitauth.dart';
import 'package:ConnectHub/cupitstate/auth/statesauth.dart';
import 'package:ConnectHub/pages/auth/login.dart';
import 'package:ConnectHub/pages/auth/reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
    Homepage({super.key});

  @override
  State<Homepage> createState() => Homepagee();
}

class Homepagee extends State<Homepage> {
  int count=0;
  
  @override
  Widget build(BuildContext context) {
    cubitclass cupit=BlocProvider.of<cubitclass>(context);
    return Scaffold(
        backgroundColor:   Color.fromARGB(255, 255, 223, 252),
        appBar: AppBar(title:  Center(child: Text("profile"),),),
        body: BlocBuilder<cubitclass,States>(builder:(context,state){

          if(state is lodinglogin ||state is lodingreg)return Text("is loading");
            
          if(state is sucssfullogin ||state is sucssfulreg){
          return Center(child: 
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRR0njhYvua2lQRzTCVfLEKg1tZVkAU3QLbbRgH48R4Q&s=10"),),
            SizedBox(height: 20,),
          Row(
           mainAxisAlignment: MainAxisAlignment.center, 
          children: [
          Center(child:Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(25),
              border: Border.all(
                style: BorderStyle.solid,
                color:   Color.fromARGB(255, 105, 95, 65)),
                color:  Color.fromARGB(255, 230, 221, 167)
              ),
               child:  Center(child: Text("eman") )
          )),
            Icon(Icons.person )
        ],
       ),
          SizedBox(height: 20,),
          Row(
           mainAxisAlignment: MainAxisAlignment.center, 
          children: [
          Center(child:Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(25),
              border: Border.all(
                style: BorderStyle.solid,
                color:   Color.fromARGB(255, 105, 95, 65)),
                color:  Color.fromARGB(255, 230, 221, 167)
              ),
               child:  Center(child: Text("30/4/2004") )
          )),
            Icon(Icons.date_range )
        ],
       ),
          SizedBox(height: 20,),
          Row(
           mainAxisAlignment: MainAxisAlignment.center, 
          children: [
          Center(child:Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(25),
              border: Border.all(
                style: BorderStyle.solid,
                color:   Color.fromARGB(255, 105, 95, 65)),
                color:  Color.fromARGB(255, 230, 221, 167)
              ),
               child:  Center(child: Text("flutter") )
          )),
            Icon(Icons.flutter_dash_rounded )
        ],
       ),
         SizedBox(height: 20,),
       Row(
           mainAxisAlignment: MainAxisAlignment.center, 
          children: [
          Center(child:Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(25),
              border: Border.all(
                style: BorderStyle.solid,
                color:   Color.fromARGB(255, 105, 95, 65)),
                color:  Color.fromARGB(255, 230, 221, 167)
              ),
               child:  Center(child: Text(count.toString()) )
          )),
            Icon(Icons.thumb_up )
        ],
       ),
         SizedBox(height: 20,),
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           ElevatedButton(onPressed: ()async{
            await cupit.logout();
            Navigator.push(context,MaterialPageRoute(builder: (context){return Login();}));
           
           }, child:   Text("logout account")),
           ElevatedButton(onPressed: ()async{
            await cupit.delet();
            Navigator.push(context,MaterialPageRoute(builder: (context){return Registers();}));
           
            
           }, child:   Text("delet account"))
         ],
       )]),
    );}else if(state is errorlogin)
    return SizedBox(child: TextButton(onPressed: (){ Navigator.pop(context);},child: Text("do not found user return page"),));
    else if (state is errorreg)
    return SizedBox(child: TextButton(onPressed: (){ Navigator.pop(context);},child: Text("user is found"),));
    else 
    return SizedBox(child: TextButton(onPressed: (){ Navigator.pop(context);},child: Text("error"),));}
    ));
  }
}