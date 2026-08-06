import 'package:flutter/material.dart';
import 'package:flutter_application_1/cupitstate/cupit.dart';
import 'package:flutter_application_1/cupitstate/states.dart';
import 'package:flutter_application_1/pages/wepp.dart';
import 'package:flutter_application_1/service/fetch.dart';
import 'package:flutter_application_1/widget/cardd.dart';
import 'package:flutter_application_1/widget/containerplant.dart';
import 'package:flutter_application_1/widget/load.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  
  List<String> plant=["general","health","science","sports","technology","business","entertainment"];
  String current="general";
  
 
  @override
  Widget build(BuildContext context) {
    Cupitclass cupit=BlocProvider.of<Cupitclass>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("app"),),
      body: Column(
        children: [
          SizedBox(
            height: 64,
            width: double.infinity,
            child: 
               ListView.builder(
                
                scrollDirection: Axis.horizontal,
                itemCount: plant.length,
                itemBuilder: (context,index){
                return GestureDetector(onTap: () {
                  setState(() {
                     current=plant[index];  
                  }
                  );
                  cupit.feettch(catugary: current);},
                
                child: Containerplant(name:plant[index],isselect:current==plant[index]) ,);
                
              
              }
              ),
            ),
             const Divider(indent: 20,endIndent: 20,),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<Cupitclass, states>(
                builder: (context, state) {
                if(state is loadingfetch){
                return Load();}
               if(state is sucssfulfetch){ 
                 return ListView.builder(
                itemCount: cupit.news.length,
                itemBuilder: (context,index){
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => SimpleWebView(url: cupit.news[index]["url"]) ));
                  },
                   child:Cardd(title: cupit.news[index]["title"]??"",description:cupit.news[index]["description"]??"" ,urlToImage:cupit.news[index]["urlToImage"]??"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMxd--j-RGBrojWnaUm0ugr8YF7aGEdBRdlhDHY937KLWCka3_ksfdISTr&s=10",)); 
              });}else{
                return SizedBox(width: 15,);
              }})
            ))
        ],
      ),
        
      )
    ;
  }
}
