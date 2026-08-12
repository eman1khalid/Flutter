import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class likeusers extends StatefulWidget {
  final List likesUsers;
  const likeusers({super.key,required this.likesUsers});

  @override
  State<likeusers> createState() => _likeusersState();
}

class _likeusersState extends State<likeusers> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("likes"),),
      body: ListView.builder(
        itemCount: widget.likesUsers.length,
        itemBuilder: (context,index){
          return StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection("users").doc(widget.likesUsers[index]).snapshots(),
       builder: (context,snapshot){
       if (snapshot.hasError){return const Center(child: Icon(Icons.error,color: Color.fromARGB(209, 244, 67, 54),));}
       if(snapshot.connectionState==ConnectionState.waiting) {
         return const Center(child: CircularProgressIndicator());
       }
       if(!snapshot.hasData ||!snapshot.data!.exists){
        return SizedBox.shrink();
       }
       else{
        var data=snapshot.data!.data() as Map<String,dynamic>;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            CircleAvatar(backgroundImage:data["imagrurl"]==null?NetworkImage("https://cdn-icons-png.flaticon.com/512/149/149071.png"):NetworkImage(data["imagrurl"]!),radius: 25,),
            SizedBox(width: 15,),
            Text(data["name"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: const Color.fromARGB(255, 101, 100, 100)))
          ],),
        );

       }});
          
        
        }) ,
    );
  }
}