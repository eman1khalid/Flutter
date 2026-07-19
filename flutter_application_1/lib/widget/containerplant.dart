import 'package:flutter/material.dart';

class Containerplant extends StatefulWidget {
  final String name;
  bool isselect;
  Containerplant( {super.key ,required this.name ,required this.isselect});

  @override
  State<Containerplant> createState() => _ContainerplantState();
}

class _ContainerplantState extends State<Containerplant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      height: 50,
      width: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: widget.isselect?const Color.fromARGB(255, 190, 23, 246):const Color.fromARGB(255, 229, 196, 235)),
      child: Center(child: Text(widget.name,)),);
  }
}