import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 223, 252),
        appBar: AppBar(title:Center(child: Text("profile"),),),
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
                  color: const Color.fromARGB(255, 105, 95, 65)),
                  color:const Color.fromARGB(255, 230, 221, 167)
                ),
                 child:Center(child: Text("eman") )
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
                  color: const Color.fromARGB(255, 105, 95, 65)),
                  color:const Color.fromARGB(255, 230, 221, 167)
                ),
                 child:Center(child: Text("30/4/2004") )
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
                  color: const Color.fromARGB(255, 105, 95, 65)),
                  color:const Color.fromARGB(255, 230, 221, 167)
                ),
                 child:Center(child: Text("flutter") )
            )),
            Icon(Icons.flutter_dash_rounded )
          ],
         ),
         SizedBox(height: 20,),
         ElevatedButton(onPressed: (){}, child: Text("save"))]),
      )),
      );
  }
}

