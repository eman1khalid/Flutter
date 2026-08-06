import 'package:ConnectHub/pages/editpage.dart';
import 'package:ConnectHub/servies/serviespost.dart';
import 'package:ConnectHub/widget/notecard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Notepage extends StatefulWidget {
  String? nodeid;
  String? title;
  String?description;
   Notepage({this.nodeid,this.title,this.description,super.key});

  @override
  State<Notepage> createState() => _NotepageState();
}

class _NotepageState extends State<Notepage> {
  
  @override
  Widget build(BuildContext context) {
    final String? userid = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      appBar: AppBar(title: Text("notepage"),),
      
      body: 
     
      userid !=null?
       StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("notes").doc(userid).collection("noteuser").snapshots(),
       builder: (context,snapshot){
       if (snapshot.hasError){return Text("error");}
       if(snapshot.connectionState==ConnectionState.waiting)
       return CircularProgressIndicator();
       if (snapshot.data!.docs.isEmpty)
       return Text("notes is empty");
       else{
        var data=snapshot.data!.docs;
        return ListView.builder(
        itemCount:data.length ,
        itemBuilder: (context,index){
        var sample= data[index].data() as Map<String,dynamic>;
      { return NoteCard(
        title: sample["title"],
        content: sample["description"],
        onDelete: () {
          Firebasestores firebasestores=Firebasestores();
          firebasestores.deletnote(nodeid: data[index].id );
        },
        onEdit: () {
          var nodeid=data[index].id;
          
          Navigator.push(context,MaterialPageRoute(builder: (context){return NoteFormScreen(
            noteId: nodeid,
            initialTitle: sample["title"],
            initialContent: sample["description"] ,
          );
        }));
        });

  }});}}
  ):
    Text("no found user"),
  floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoteFormScreen()),
          );
        },)


);}}
