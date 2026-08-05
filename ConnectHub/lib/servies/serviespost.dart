import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebasestores{
   FirebaseFirestore firestore =FirebaseFirestore.instance;
  var userid=FirebaseAuth.instance.currentUser?.uid;
  Future <void> addnote({required String title,required String description})async{
    await firestore.collection("notes")
    .doc(userid)
    .collection("noteuser")
    .add({
      "title": title,
      "description": description, // ملاحظة: يفضل تصحيح الإملاء لتصبح description
    });}
    Future <void> uodatenote({required String nodeid, required String title,required String description})async{
    await firestore.collection("notes")
    .doc(userid)
    .collection("noteuser").doc(nodeid)
    .update({
      "title": title,
      "description": description, // ملاحظة: يفضل تصحيح الإملاء لتصبح description
    });}
    Future <void> deletnote({required String nodeid})async{
    await firestore.collection("notes")
    .doc(userid)
    .collection("noteuser").doc(nodeid)
    .delete();
    }}

