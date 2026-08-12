import 'package:ConnectHub/globalvariable.dart';
import 'package:ConnectHub/cupitstate/posts/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Firebasestores extends Cubit<Statespost>{
   FirebaseFirestore firestore =FirebaseFirestore.instance;
  Firebasestores():super(Intialstatepost());
  Future <void> addpost({required String title,required String description,  String? image})async{
    emit(loadingpost());
    try{
    await firestore.collection("posts")
    .add({
      "title": title,
      "description": description,
       "image":image,
       "userid":userid,
       "time":FieldValue.serverTimestamp(),
       "likesCount": 0,          // يبدأ الصفر بـ عدد اللايكات
       "likesUsers": [],
    });}catch(e){
    emit(errorpost());
    }}  
     Future <void> updatepost({required String postid, required String title,required String description,required String? image})async{
    await firestore.collection("posts")
    .doc(postid)
    .update({
      "title": title,
      "description": description,
      "image":image,
       // ملاحظة: يفضل تصحيح الإملاء لتصبح description
    });}
    Future <void> deletpost({required String postid})async{
      WriteBatch batch = firestore.batch();
    var comment= await firestore.collection("posts"). doc(postid).collection("comments").get();
    for(var doc in comment.docs){
      batch.delete(doc.reference);
    }
    await firestore.collection("posts").doc(postid).delete();
    }
    Future<void> toggleLike({required String postId, required List currentLikesUsers}) async {
  try {
    DocumentReference postRef = firestore.collection("posts").doc(postId);

    if (currentLikesUsers.contains(userid)) {
      // لو المستخدم عامل لايك قبل كده -> نشيل اللايك (Unlike)
      await postRef.update({
        "likesCount": FieldValue.increment(-1), // ينقص واحد
        "likesUsers": FieldValue.arrayRemove([userid]), // يمسح الـ ID بتاعه
      });
    } else {
      // لو مش عامل لايك -> نضيف اللايك (Like)
      await postRef.update({
        "likesCount": FieldValue.increment(1), // يزود واحد
        "likesUsers": FieldValue.arrayUnion([userid]), // يضيف الـ ID بتاعه
      });
    }
  } catch (e) {
    emit(errorpost());
  }
}
    Future<void> addcomments({required String postid,required String comment})async{
    try{
      await FirebaseFirestore.instance.collection("posts").doc(postid).collection("comments").add({
        "commentcontent":comment,
        "userimage":imageuser,
        "username":username,
        "time":FieldValue.serverTimestamp()

      });
    }catch(e){

    }

  }
    }
  