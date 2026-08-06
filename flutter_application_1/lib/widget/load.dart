import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Load extends StatefulWidget {
  const Load({super.key});

  @override
  State<Load> createState() => _LoadState();
}

class _LoadState extends State<Load> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

       child: Column(
        mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children :[
        const Text("loading news .....",style: TextStyle(color: Color.fromARGB(255, 247, 220, 229) ,fontWeight:FontWeight.bold,fontSize: 30,))
       ,Expanded(child:Lottie.asset('assets/lottiefile/GlobeAnimation.json')),

       
       ],),
     );
  }
}