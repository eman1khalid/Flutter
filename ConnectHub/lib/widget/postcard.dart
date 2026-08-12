import 'package:ConnectHub/cupitstate/posts/cupitpost.dart';
import 'package:ConnectHub/globalvariable.dart';
import 'package:ConnectHub/pages/creatposts.dart';
import 'package:ConnectHub/pages/likepage.dart';
import 'package:ConnectHub/pages/postdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Postcard extends StatefulWidget {
             final String postId;
             final String userId;
             final String username;
              final String? imageprofile;
              final String posttitle;
              final String postdescription;
              final String time;
              final String? postImageUrl;
              final String likesCount;
              final List likesUsers;
  const Postcard({super.key,required this.postId,required this.userId,required this.username, this.imageprofile,required this.time,
  required this.likesUsers,required this.likesCount, this.postImageUrl,required this.postdescription,required this.posttitle});

  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {

  
  @override
  Widget build(BuildContext context) {
    String? urlImage=widget.postImageUrl;
    return  Padding(
        padding: const EdgeInsets.all(5),
        child: Stack(
          children: [
            Container(
              color: const Color.fromARGB(255, 246, 243, 250),
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(children: [
                   CircleAvatar(backgroundImage:widget.imageprofile!=null? NetworkImage(widget.imageprofile!):NetworkImage("https://cdn-icons-png.flaticon.com/512/149/149071.png"),radius: 25,),
                   SizedBox(width: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(widget.username,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: const Color.fromARGB(255, 101, 100, 100)),)),
                      Text(widget.time,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12,color: const Color.fromARGB(255, 181, 178, 178)),)
                    ],
                  )
                ],),
                
                SizedBox(height: 20,),
                Text(widget.posttitle,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: const Color.fromARGB(255, 54, 54, 54)),),
                Text(widget.postdescription,style: TextStyle(fontWeight: FontWeight.normal,fontSize:15,color: const Color.fromARGB(255, 54, 54, 54)),),
                urlImage==null?SizedBox.shrink():
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (context){
                       return Dialog(
                        insetPadding: EdgeInsets.zero,
                        child: InteractiveViewer(child: Image.network(urlImage))
                        ,
                       );
                    });
                  },
                  child: ClipRRect(
                    child: Image.network(urlImage),
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    IconButton( onPressed: (){
                     BlocProvider.of<Firebasestores>(context).toggleLike(postId: widget.postId, currentLikesUsers: widget.likesUsers);
                    }, icon:widget.likesUsers.contains(userid)? Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border)),
                    GestureDetector(child:Text(widget.likesCount) ,onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>likeusers(likesUsers: widget.likesUsers,)));
                    },)
                    ,
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(
                      create:(context)=>Firebasestores(),
                      child:Postdetails(
                        postId:widget.postId))));
                    }, icon:const Icon(Icons.mode_comment_outlined)),
                    StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("posts").doc(widget.postId).collection("commments").snapshots(),
                     builder: (context,snapshot){
                      if(snapshot.hasData) {
                        return Text(snapshot.data!.docs.length.toString());
                      } else {
                        return const Text("0");
                      }
                     })
                    ,
                  ],
                )
              ],),
            ),
           
            widget.userId==userid?
                 Positioned(
                             top: 3,
                             right: 3,
                             child:  Row(
                               children: [
                                 IconButton(onPressed: (){
                                  BlocProvider.of<Firebasestores>(context).deletpost(postid: widget.postId);
                                 }, icon: const Icon(Icons.delete),color: const Color.fromARGB(255, 205, 17, 3),),
                                 IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PostFormScreen(
                                    postid: widget.postId,
                                    initialTitle: widget.posttitle,
                                    initialContent: widget.postdescription,
                                    intialimage: widget.postImageUrl,
                                  )));
                                  }, icon: const Icon(Icons.edit),color: const Color.fromARGB(255, 3, 107, 205),),
                               ],
                             ),
                 
                             
                           )
                 
              :SizedBox.shrink()

          ],
        ),
      ) ; 
    
  }
}