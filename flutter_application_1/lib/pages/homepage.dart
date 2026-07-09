import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
    Homepage({super.key});

  @override
  State<Homepage> createState() => Homepagee();
}

class Homepagee extends State<Homepage> {
  int count=0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:   Color.fromARGB(255, 255, 223, 252),
        appBar: AppBar(title:  Center(child: Text("profile"),),),
        body: Center(child: 
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
           ElevatedButton(onPressed: (){
            
            setState(() {
              count++;
            });
           }, child:   Text("like")),
           ElevatedButton(onPressed: (){
           
            setState(() {
               count--;
            });
           }, child:   Text("deslike"))
         ],
       )]),
    ));
  }
}