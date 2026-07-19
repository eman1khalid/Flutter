import 'package:flutter/material.dart';
import 'package:flutter_application_1/cupitstate/cupit.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class news extends StatefulWidget {
  const news({super.key});

  @override
  State<news> createState() => _newsState();
}

class _newsState extends State<news> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(centerTitle:true,backgroundColor:Colors.purple ,),
     body: SizedBox(
      width: double.infinity,

       child: Column(
        mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children :[
        const Text("news app",style: TextStyle(color: Colors.pinkAccent ,fontWeight:FontWeight.bold,fontSize: 30,))
       ,Expanded(child:Lottie.asset('assets/lottiefile/GlobalNetwork.json')),
       ElevatedButton(onPressed: (){
        BlocProvider.of<Cupitclass>(context).feettch(catugary:"general") ;
        Navigator.push(context,MaterialPageRoute(builder: (context){return const Homepage();}));}, child: const Text("تعرف على المزيد من الاخبار "))
       ],),
     ),
    );
  }
}