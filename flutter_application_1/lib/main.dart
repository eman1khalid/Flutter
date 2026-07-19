import 'package:flutter/material.dart';
import 'package:flutter_application_1/cupitstate/cupit.dart';
import 'package:flutter_application_1/pages/plants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
void main() {
  // التأكد من تهيئة كل خدمات فلاتر قبل تشغيل الويب فيو
  WidgetsFlutterBinding.ensureInitialized();
  
  WebViewPlatform.instance = AndroidWebViewPlatform();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context)=>Cupitclass()
    ,child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: news(),
      ));
  }
}

