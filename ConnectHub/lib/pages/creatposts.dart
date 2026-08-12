import 'dart:io';
import 'package:ConnectHub/cupitstate/posts/cupitpost.dart';
import 'package:ConnectHub/globalvariable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PostFormScreen extends StatefulWidget {
  final String? postid;
  final String? initialTitle;
  final String? initialContent;
  final String? intialimage;

  const PostFormScreen({
    this.postid,
    this.initialTitle,
    this.initialContent,
    this.intialimage,
    super.key,
  });
  

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  
  var intialimage;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
   @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? "";
    _contentController.text = widget.initialContent ?? "";
    intialimage=widget.intialimage;
    
  }
  
  File? selectedImage; 
  var url;
 
  
  @override
  Widget build(BuildContext context) {
    
    bool isEditing=widget.postid!=null;
    String?postid=widget.postid;
    return Scaffold(
     body:  Padding(
        padding: const EdgeInsets.all(35),
        child: ListView(children: [
          Row(children: [
             CircleAvatar(backgroundImage:imageuser==null? NetworkImage("https://image.idntimes.com/post/20240207/33bac083ba44f180c1435fc41975bf36-ca73ec342155d955387493c4eb78c8bb.jpg"):NetworkImage(imageuser!),radius: 25,),
             SizedBox(width: 10,),
            Text("you",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: const Color.fromARGB(255, 101, 100, 100)),)
          ],),
          Spacer(),
          SizedBox(height: 20,),
          Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'content'),
            ),
            const SizedBox(height: 20),
            selectedImage==null &&intialimage==null?TextButton.icon(
              onPressed:()async{ 
                var fileimage=await pickImage();
                setState(() {
                  selectedImage=fileimage;
                });
              var imm;
              fileimage!=null?  imm=await imagebb(image: fileimage):imm=null;
              setState(() {
                url=imm;
                intialimage=imm;
              });
              }, 
              label: Text("Add an image to the post"),icon:Icon(Icons.image) ,):
            Stack(children: [
            GestureDetector(
            onTap: () {
              showDialog(context: context, builder: (context){
                 return 
                 
                  Dialog(
                  insetPadding: EdgeInsets.zero,
                  child: InteractiveViewer(child:intialimage==null? Image.file(selectedImage!):Image.network(intialimage!)),);
                 
              });
            },
            child: ClipRRect(
              child: intialimage==null? Image.file(selectedImage!):Image.network(intialimage)
            ),
          ),
          Positioned(
            child:  IconButton(onPressed: (){setState(() {selectedImage=null;url=null; intialimage=null; }); }, icon: Icon(Icons.delete),color: const Color.fromARGB(255, 205, 17, 3),),
            top: 3,
            right: 3,

            
          )]),
          url!=null || selectedImage==null ?
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
               isEditing?
               BlocProvider.of<Firebasestores>(context).updatepost(
                postid: postid!,
                title:_titleController.text.trim(),
                description:_contentController.text.trim(),
                image:intialimage, 
               )
               : BlocProvider.of<Firebasestores>(context).addpost(
                title:_titleController.text.trim(),
                description:_contentController.text.trim(),
                image:intialimage
               );
               Navigator.pop(context);
              },
              child: Text(isEditing?"edit post":"Publish the post"),
            ):Text("loading image"),
          ],
        ),
      ),
          
        ],),
      ) 
    );
  }
}
/* class PostFormScreen extends StatefulWidget {
  final String? noteId;
  final String? initialTitle;
  final String? initialContent;
  final String? intialimage;

  const PostFormScreen({
    this.noteId,
    this.initialTitle,
    this.initialContent,
    this.intialimage,
    super.key,
  });

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  Firebasestores firebasestores=Firebasestores();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? "";
    _contentController.text = widget.initialContent ?? "";
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.noteId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "تعديل الملاحظة" : "إضافة ملاحظة"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'العنوان'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'المحتوى'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if(widget.noteId==null) {
                  //firebasestores.addnote(title:_titleController.text, description: _contentController.text);
                }else{
                  //firebasestores.uodatenote(nodeid: widget.noteId!, title: _titleController.text, description: _contentController.text);
                }
                if (mounted) Navigator.pop(context);
              },
              child: Text(isEditing ? "تحديث الملاحظة" : "حفظ الملاحظة"),
            ),
          ],
        ),
      ),
    );
  }
}*/