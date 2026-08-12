import 'package:ConnectHub/pages/postdetails.dart';
import 'package:ConnectHub/widget/postcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  String? postid;
  String? title;
  String?description;
  String?image;
   Homepage({this.postid,this.title,this.description,this.image,super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Homepage"),),
       body: 
       StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("posts").snapshots(),
       builder: (context,snapshot){
       if (snapshot.hasError){return const Center(child: Icon(Icons.error,color: Color.fromARGB(209, 244, 67, 54),));}
       if(snapshot.connectionState==ConnectionState.waiting) {
         return const Center(child: CircularProgressIndicator());
       }
       if (snapshot.data!.docs.isEmpty) {
         return const Center(child: Text("no posts"));
       } else{
        var data=snapshot.data!.docs;
        data.shuffle();

        return ListView.builder(
        itemCount:data.length ,
        itemBuilder: (context,index){
        var sample= data[index].data() as Map<String,dynamic>;
        var postid=data[index].id;
        var useridd=sample["userid"];
               return FutureBuilder<DocumentSnapshot>(future: FirebaseFirestore.instance.collection("users").doc(useridd).get(), builder: 
               (context,usnapshot){
               if (usnapshot.connectionState==ConnectionState.waiting)return const SizedBox.shrink();
               if(usnapshot.hasError)return const Text("error");
               if(!usnapshot.data!.exists)return const Text("empty");
               var datauser=usnapshot.data!.data() as Map <String,dynamic>;
               return GestureDetector(child:Postcard(
              postId:postid,
              userId:useridd,
              username:datauser["name"],
              imageprofile:datauser["imagrurl"],
              posttitle:sample["title"],
              postdescription:sample["description"],
              postImageUrl:sample["image"],
              time:sample["time"]!=null?(sample["time"] as Timestamp).toDate().toString():"just now",
              likesCount:sample["likesCount"].toString(),
              likesUsers:sample["likesUsers"],
        
              ),
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>
          Postdetails(
            postId:postid,
            
          )));},);
          

        

  });});}}
  ),
  
 
);

}
}