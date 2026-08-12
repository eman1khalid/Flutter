import 'package:ConnectHub/cupitstate/auth/cupitauth.dart';
import 'package:ConnectHub/globalvariable.dart';
import 'package:ConnectHub/pages/auth/login.dart';
import 'package:ConnectHub/pages/auth/reg.dart';
import 'package:ConnectHub/pages/postdetails.dart';
import 'package:ConnectHub/widget/postcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profilepage extends StatefulWidget {
    const Profilepage({super.key});
    

  @override
  State<Profilepage> createState() => Profilepagee();
}

class Profilepagee extends State<Profilepage> {
 int count = 0;
  
  // تعريف الكنترولرات
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController overview = TextEditingController();

  @override
  void initState() {
    super.initState(); // ضروري جداً تنادي عليها هنا
    // تعيين القيمة أول ما الشاشة تفتح
    name.text = username ?? "Anonymous";
  }

  @override
  void dispose() {
    name.dispose();
    date.dispose();
    overview.dispose();
    super.dispose();
  }
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   String? url;
   var fileimage;
  @override
  Widget build(BuildContext context) {
    
    cubitclass cupit=BlocProvider.of<cubitclass>(context);
    return Scaffold(
        backgroundColor:   Color.fromRGBO(242, 234, 241, 1),
        appBar: AppBar(title:  Center(child: Text("profile"),),),
        body: Center(child: 
       Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child:
              Form(
                key: _formKey,
                child: Row(
                  children: [
                    Stack(
                    children: [
                      CircleAvatar(
                    radius: 35,
                    backgroundImage:fileimage!=null?FileImage(fileimage) :
                    imageuser==null? NetworkImage("https://cdn-icons-png.flaticon.com/512/149/149071.png"):NetworkImage(imageuser!),),
                    Positioned(
                      top: -10,
                      right: -10,
                      child:  IconButton(onPressed: ()async{
                        var pick=await pickImage();
                        setState(() {
                          fileimage=pick;
                        });
                
                      } , icon: Icon(Icons.edit),color: const Color.fromARGB(255, 111, 3, 205),),
                
                      
                    )] ),
                   
                   Row(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: [
                          SizedBox(width: 15,),
                          Center(child:Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(25)),
                              child: TextFormField(
                                controller: name,
                                decoration: InputDecoration(hintText: username ,border: InputBorder.none),
                                validator: (value) {
                                  if(value!.isEmpty)
                                  return "please enter name";
                                  return null;
                                },
                              )
                              
                          )),
                            
                      ],
                    ),
                    
                    ElevatedButton(onPressed: ()async{
                      
                      if(_formKey.currentState!.validate() ) {
                        if(fileimage!=null){
                          url=await imagebb(image: fileimage!);}
                          imageuser =url==null?imageuser:url;
                          username=name.text.trim();
                          cupit.uodateuser(name: username, image: imageuser);
                        
                      }
                      }, child: const Text("save edit"))
                    
                                     ],
                  
                ),
              ),),
              const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: ()async{
                  await cupit.logout();
                  Navigator.push(context,MaterialPageRoute(builder: (context){return Login();}));
                
                }, child:   Text("logout account")),
                ElevatedButton(onPressed: ()async{
                  await cupit.delet();
                  Navigator.push(context,MaterialPageRoute(builder: (context){return Registers();}));
                
                  
                }, child:   Text("delet account"))
              ],
            )
             
         ,StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("posts").where("userid",isEqualTo: userid).orderBy("time", descending: true).snapshots(),
          builder: (context,snapshot){
            if (snapshot.hasError){return Expanded(child: const Center(child: Icon(Icons.error,color: Color.fromARGB(209, 244, 67, 54),)));}
            if(snapshot.connectionState==ConnectionState.waiting) {
              return const Expanded(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Expanded(child: Center(child: Text("No posts. Create your post now.")));
                } else{
                  var data=snapshot.data!.docs ;
               return Expanded(child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,index){
                var sample=data[index].data() as Map<String,dynamic>;
                String postid=data[index].id;

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
          

        

  });}));
              }}),
          ]
              )
              ));

              }}
            
