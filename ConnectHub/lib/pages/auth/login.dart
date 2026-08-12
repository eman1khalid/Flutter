import 'package:ConnectHub/cupitstate/auth/cupitauth.dart';
import 'package:ConnectHub/cupitstate/auth/statesauth.dart';
import 'package:ConnectHub/cupitstate/posts/cupitpost.dart';
import 'package:ConnectHub/navigationbar.dart';
import 'package:ConnectHub/pages/auth/forgetpassword.dart';
import 'package:ConnectHub/pages/auth/reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> keyform =GlobalKey<FormState>();
    TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    cubitclass cupit=BlocProvider.of<cubitclass>(context);
  
    return BlocBuilder<cubitclass,States>(builder: (context,state){return Scaffold(
      appBar: AppBar(title: const Text("login page"),centerTitle: true,foregroundColor: const Color.fromARGB(255, 123, 22, 223),backgroundColor: const Color.fromARGB(82, 29, 18, 244)),
      body:Form(
        key:keyform,
        child:   Center(child: 
         Padding(
           padding: const EdgeInsets.all(25),
           child:Padding(
             padding: const EdgeInsets.all(25),
             child: ListView(  children: [Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 90,),
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage("assets/images/logoapp.png"),),
                  SizedBox(height: 18,),
                  TextFormField(
                   controller: email,
                    validator: (value) {
                      if(value!.isEmpty||!value.contains("@"))
                      return "please enter correct email";
                      return null;
                    },
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                    label:Text("email"),suffixIcon: Icon(Icons.email),hintText: "please enter email"),
                    
                  ),
                const SizedBox(height: 20,),
                TextFormField(
                   controller: password,
                    validator: (value) {
                      if(value!.isEmpty||value.length<8)
                      return"please enter password contain digits";
                      return null;
                      
                    },
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                    label:Text("password"),suffixIcon: Icon(Icons.password),hintText: "please enter email"),
                    
                  ),SizedBox(height: 18,),
                  state is lodinglogin?CircularProgressIndicator(color: const Color.fromARGB(255, 183, 232, 255),):SizedBox.shrink(),
                  state is errorlogin?Text("خطا في الايميل او كلمه المرور",style: TextStyle(color: const Color.fromARGB(255, 255, 154, 147)),):SizedBox.shrink(),
                  ElevatedButton(onPressed: ()async{
                   
                
                          if (keyform.currentState!.validate()) {
                            // 1. تنفيذ الدخول وانتظار النتيجة
                            await cupit.login(email.text.trim(), password.text.trim());
                            
                            // 2. التحقق من الستيت الحالية بعد انتهاء الدالة والانتقال
                            if (cupit.state is sucssfullogin) {
                              if (!context.mounted) return;
                              
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) {return BlocProvider(
                                create:(context)=>Firebasestores(),
                                child:navbar(),);}),
                              );
                            }
                          }
                      
                  
                  },child: Text("login"),),
                  TextButton(onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context){return Forgetpassword();}));
                  }, child: Text("forget password?")),
                  TextButton(onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context){return Registers();}));
             
                  }, child: Text("do not have user"))
                   ])]),
           )
                
                  
                )
            ),
         ))  ; }  
    );
  }

  String get newMethod => "save";
}