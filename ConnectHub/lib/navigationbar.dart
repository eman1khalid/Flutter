import 'package:ConnectHub/cupitstate/ai/cupitai.dart';
import 'package:ConnectHub/cupitstate/posts/cupitpost.dart';
import 'package:ConnectHub/pages/chatbot.dart';
import 'package:ConnectHub/pages/creatposts.dart';
import 'package:ConnectHub/pages/homepage.dart';
import 'package:ConnectHub/pages/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class navbar extends StatefulWidget {
  const navbar({super.key});

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  List pages=[
    Profilepage(),
    
    Homepage() ,
    BlocProvider(
    create:(context)=>Cupitai(),
    child:chatpot() ,),
  ];
  int crruntindex=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[crruntindex],
      floatingActionButton:
      crruntindex==2?SizedBox.shrink():
       FloatingActionButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>BlocProvider(
      create:(context)=>Firebasestores(),child:PostFormScreen(),), ));}, 
      child: Icon(Icons.add,color: const Color.fromARGB(255, 160, 108, 227),)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 74, 0, 194),
        selectedItemColor: const Color.fromARGB(255, 212, 176, 255),
        unselectedItemColor: const Color.fromARGB(255, 251, 250, 250),
        onTap: (index){
          setState(() {
             crruntindex=index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person,),label: "my profile"),
          BottomNavigationBarItem(icon: Icon(Icons.home,),label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy_outlined,),label: "chatbot")
        ]),
    );
  }
}