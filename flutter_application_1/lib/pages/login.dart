import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/homepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> keyform =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("login page"),centerTitle: true,foregroundColor: const Color.fromARGB(255, 223, 22, 133),backgroundColor: const Color.fromARGB(84, 223, 22, 133),),
      body:Form(
        key:keyform,
        child:   Center(child: 
         Padding(
           padding: const EdgeInsets.all(25),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/images/image1.jpg"),),
                SizedBox(height: 18,),
                TextFormField(

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
                  validator: (value) {
                    if(value!.isEmpty||value!.length<8)
                    return"please enter password contain digits";
                    return null;
                    
                  },
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  label:Text("password"),icon: Icon(Icons.password),hintText: "please enter email"),
                  
                ),SizedBox(height: 18,),
                ElevatedButton(onPressed: (){
                if(keyform.currentState!.validate()) {
                  Navigator.push(context,MaterialPageRoute(builder: (context){return Homepage();}));
                }
                }, child: Text("login"))
            ]),
         ))     
    ));
  }

  String get newMethod => "save";
}