import 'package:app2/cupitstate/cupit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app2/pages/homepage.dart';
import 'package:app2/pages/login.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart'; // تأكدي من استيراد هذا الملف الذي تم توليده

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);




  runApp(const MyApp()); // اسم الـ Widget الأساسية لتطبيقكِ
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>cubitclass()
    ,child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      ));
  }
}