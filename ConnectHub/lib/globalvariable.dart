import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

String? get userid=>FirebaseAuth.instance.currentUser?.uid;
String ?username;
String?imageuser;
  final ImagePicker picker = ImagePicker();
  Future<File?> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      
       return  File(image.path);
      
    }
    else {
      return null;
    }
  }                      
  Future<String> imagebb({required File image}) async {
  try {
    // 1. تجهيز الـ FormData وربط الملف بالمفتاح الذي يتوقعه السيرفر ("image")
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(image.path),
    });

    // 2. إرسال الطلب باستخدام Dio مع الـ FormData
    var response = await Dio().post(
      "https://api.imgbb.com/1/upload?key=c643e182da3bc7b0362e914273b8f948",
      data: formData,
    );

    String url = response.data["data"]["url"];
    return url;
    
  } on DioException catch (e) {
    print("STATUS CODE: ${e.response?.statusCode}");
    print("ERROR BODY: ${e.response?.data}");
    return "";
  }
}