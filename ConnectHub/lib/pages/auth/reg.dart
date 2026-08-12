import 'dart:io';
import 'package:ConnectHub/cupitstate/auth/cupitauth.dart';
import 'package:ConnectHub/cupitstate/auth/statesauth.dart';
import 'package:ConnectHub/cupitstate/posts/cupitpost.dart';
import 'package:ConnectHub/globalvariable.dart';
import 'package:ConnectHub/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ConnectHub/pages/auth/login.dart';

class Registers extends StatefulWidget {
  const Registers({super.key});

  @override
  State<Registers> createState() => _RegistersState();
}

class _RegistersState extends State<Registers> {
  GlobalKey<FormState> keyform =GlobalKey<FormState>();
    TextEditingController name=TextEditingController();
    TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();
    File? selectedImage;
  @override
  Widget build(BuildContext context) {
    cubitclass cupit=BlocProvider.of<cubitclass>(context);
    
  
    return BlocBuilder<cubitclass,States>(builder: (context,state){return Scaffold(
      appBar: AppBar(title: const Text("Registers page"),centerTitle: true,foregroundColor: const Color.fromARGB(255, 123, 22, 223),backgroundColor: const Color.fromARGB(82, 29, 18, 244)),
      body:Form(
        key:keyform,
        child:   Center(child: 
         Padding(
           padding: const EdgeInsets.all(25),
           child: Padding(
             padding: const EdgeInsets.all(25),
             child: ListView(children: [ Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 90,),
                
                    Stack(children: [
                      GestureDetector(
                        onTap: () async {
                          File? im = await pickImage();
                          if (im != null  && mounted) {
                            setState(() {
                              selectedImage = im; 
                            });
                          }
                        },
                        child: ClipRRect(
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: selectedImage != null 
                                ? FileImage(selectedImage!) 
                                :  const NetworkImage("https://cdn-icons-png.flaticon.com/512/149/149071.png"),
                          ),
                        ),
                      ),
                        selectedImage!=null?
                        Positioned(
                          top: 3,
                          right: 3,
                          child:  IconButton(onPressed: (){setState(() {selectedImage=null;}); }, icon: Icon(Icons.delete),color: const Color.fromARGB(255, 205, 17, 3),),

                          
                        ):const SizedBox.shrink()]
                        ),
                        const SizedBox(height: 18,),
                  TextFormField(
                   controller: name,
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "please enter name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                    label:const Text("name"),suffixIcon: const Icon(Icons.person),hintText: "please enter name"),
                    
                  ),
                  const SizedBox(height: 18,),
                  TextFormField(
                  controller: email,
                    validator: (value) {
                      if(value!.isEmpty||!value.contains("@")) {
                        return "please enter correct email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                    label:const Text("email"),suffixIcon: const Icon(Icons.email),hintText: "please enter email"),
                    
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
                    
                  ),const SizedBox(height: 18,),
                  if(state is lodingreg)const CircularProgressIndicator(),
                  ElevatedButton(onPressed: ()async{
                  String? im;
                  if(keyform.currentState!.validate() ) {
                    
                    if(selectedImage!=null) {
                      print("Image Path: ${selectedImage!.path}");
                      String imurl= await imagebb(image:  selectedImage!);
                      setState(() {
                        im=imurl;
                      });
                    }
                    
                    await cupit.reg(email:email.text,password:  password.text,name: name.text,urlimg:im);
                    if (!mounted) return;
                    if(cupit.state is sucssfulreg) {
                      // ignore: use_build_context_synchronously
                      Navigator.push(context,MaterialPageRoute(builder: (context){return BlocProvider(
                        create:(context)=>Firebasestores(),
                        child:navbar(),);}));
                    }
                    
                  }
                  }, child: const Text("Registers")),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){return const Login();}));
            
                  }, child: const Text("do you have user"))
                  ])]),
          )
                
                  
                )
            ),
         ))  ; }  
    );
  }


}