import 'package:ConnectHub/cupitstate/posts/cupitpost.dart';
import 'package:ConnectHub/widget/postcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Postdetails extends StatefulWidget {
             final String postId;
             
              const Postdetails({super.key,required this.postId,});

  

  @override
  State<Postdetails> createState() => _PostdetailsState();
}

class _PostdetailsState extends State<Postdetails> {
  TextEditingController COMMENT= TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child:
         
             Column(
            children: [
               StreamBuilder <DocumentSnapshot>(stream: FirebaseFirestore.instance.collection("posts").doc(widget.postId).snapshots(),
              builder:(context,snapshot){
                if(snapshot.hasError){return const Text("error");}
                if(snapshot.connectionState ==ConnectionState.waiting)return const CircularProgressIndicator();
                if(!snapshot.data!.exists)return Text("The post is no longer available.");
                var data=snapshot.data!.data() as Map<String,dynamic>;
                var useridd=data["userid"];
               return FutureBuilder<DocumentSnapshot>(future: FirebaseFirestore.instance.collection("users").doc(useridd).get(), builder: 
               (context,usnapshot){
               if (usnapshot.connectionState==ConnectionState.waiting)return CircularProgressIndicator();
               if(usnapshot.hasError)return Text("error");
               if(!usnapshot.data!.exists)return Text("empty");
               var datauser=usnapshot.data!.data() as Map <String,dynamic>;
               return Postcard(
              postId:widget.postId,
              userId:data["userid"],
              username:datauser["name"],
              imageprofile:datauser["imagrurl"],
              posttitle:data["title"],
              postdescription:data["description"],
              postImageUrl:data["image"],
              time:data["time"]!=null?(data["time"] as Timestamp).toDate().toString():"just now",
              likesCount:data["likesCount"].toString(),
              likesUsers:data["likesUsers"],
        
              );});}), 
              
              // التعليقات
               StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("posts").doc(widget.postId).collection("comments").snapshots(),
               builder: (context,snapshot){
                 if (snapshot.hasError){return const Center(child: Icon(Icons.error,color: Color.fromARGB(209, 244, 67, 54),));}
                if(snapshot.connectionState==ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                 }
                if(snapshot.data!.docs.isEmpty){
                  return const Center(child: Text("no comments"));
                }
                else{
                  var data=snapshot.data!.docs;
                return ListView.builder(
                
                shrinkWrap: true, // مهمة جداً عشان تاخد حجم العناصر بس
                physics: const NeverScrollableScrollPhysics(), // تمنع السكرول الداخلي وتعتمد على الـ SingleChildScrollView اللي بره
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var sample= data[index].data() as Map<String,dynamic>;
                  return Container(
                    
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                            CircleAvatar(backgroundImage:sample["userimage"]!=null? NetworkImage(sample["userimage"]!):NetworkImage("https://cdn-icons-png.flaticon.com/512/149/149071.png"),radius: 25,),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(sample["username"]!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: const Color.fromARGB(255, 101, 100, 100)),),
                                Text(sample["time"]!=null?(sample ["time"] as Timestamp).toDate().toString():"just now",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12,color: const Color.fromARGB(255, 181, 178, 178)),)
                              ],
                            )
                          ],
                          ),
                           SizedBox(height: 20,),
                           Align( 
                            alignment: Alignment.centerLeft,
                            child:Text(sample["commentcontent"],style: TextStyle(fontWeight: FontWeight.normal,fontSize:15,color: const Color.fromARGB(255, 54, 54, 54)),)),
                      ],
                    )
                   
                  );
                },
              );}
           })],
          ),
        ),
      ),
      bottomNavigationBar: 
       Container(child: Padding(padding:EdgeInsets.only(
          top: 8,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 8),
          child: Row(
            children: [
              Expanded(child: 
              TextField(
                decoration:InputDecoration(label: const Text("comment"),hintText: "add comment",
                border: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(25)

                )),
                controller: COMMENT,
              )),
              SizedBox(width: 8,),
              IconButton(onPressed: (){
                BlocProvider.of<Firebasestores>(context).addcomments(postid: widget.postId, comment: COMMENT.text.trim());
                COMMENT.clear();
              }, icon: Icon(Icons.send,color: Color.fromARGB(255, 199, 30, 233),))
              
            ],
          ),
        ),
      ),
    );
  }
}