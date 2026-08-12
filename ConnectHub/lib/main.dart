import 'package:ConnectHub/cupitstate/auth/cupitauth.dart';
import 'package:ConnectHub/cupitstate/posts/cupitpost.dart';
import 'package:ConnectHub/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);




  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>cubitclass()
    ,child: BlocProvider(create: (context)=>Firebasestores()
    ,child:   MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      )));
  }
}