import 'package:ConnectHub/cupitstate/auth/cupitauth.dart';
import 'package:ConnectHub/cupitstate/auth/statesauth.dart';
import 'package:flutter/material.dart';
import 'package:ConnectHub/pages/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ConnectHub/pages/auth/login.dart';

class Registers extends StatefulWidget {
  const Registers({super.key});

  @override
  State<Registers> createState() => _RegistersState();
}

class _RegistersState extends State<Registers> {
  GlobalKey<FormState> keyform =GlobalKey<FormState>();
    TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    cubitclass cupit=BlocProvider.of<cubitclass>(context);
  
    return BlocBuilder<cubitclass,States>(builder: (context,state){return Scaffold(
      appBar: AppBar(title: const Text("Registers page"),centerTitle: true,foregroundColor: const Color.fromARGB(255, 223, 22, 133),backgroundColor: const Color.fromARGB(84, 223, 22, 133),),
      body:Form(
        key:keyform,
        child:   Center(child: 
         Padding(
           padding: const EdgeInsets.all(25),
           child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/images/image1.jpg"),),
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
                ElevatedButton(onPressed: ()async{
                 
                if(keyform.currentState!.validate() ) {
                
                  await cupit.reg(email.text, password.text);
                  
                  Navigator.push(context,MaterialPageRoute(builder: (context){return Homepage();}));
                  
                }
                }, child: Text("Registers")),
                TextButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){return Login();}));

                }, child: Text("do you have user"))
                 ])
                
                  
                )
            ),
         ))  ; }  
    );
  }

  String get newMethod => "save";
}