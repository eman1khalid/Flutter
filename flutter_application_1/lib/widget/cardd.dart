import 'package:flutter/material.dart';

class Cardd extends StatefulWidget {
  String title;
  String description;
  String urlToImage;
   Cardd({super.key,required this.title,required this.description,required this.urlToImage});

  @override
  State<Cardd> createState() => _CarddState();
}

class _CarddState extends State<Cardd> {
  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 25,
              child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(widget.urlToImage)),
                 Text( widget.title,style: const TextStyle(fontWeight: FontWeight.bold),),
                 const SizedBox(width: 8,),
                 Text(widget.description,style: const TextStyle(color: Color.fromARGB(255, 161, 159, 159)),)
              ],),
            );
  }
}