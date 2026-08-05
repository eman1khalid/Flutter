import 'package:ConnectHub/cupitstate/auth/cupitauth.dart';
import 'package:ConnectHub/cupitstate/auth/statesauth.dart';
import 'package:ConnectHub/pages/auth/reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  GlobalKey<FormState> keyform =GlobalKey<FormState>();
    TextEditingController email=TextEditingController();
    void dispose() {
    email.dispose();
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context) {
    cubitclass cupit=BlocProvider.of<cubitclass>(context);

  
    return BlocBuilder<cubitclass,States>(builder: (context,state){return Scaffold(
      appBar: AppBar(title: const Text("Forgetpassword page"),centerTitle: true,foregroundColor: const Color.fromARGB(255, 223, 22, 133),backgroundColor: const Color.fromARGB(84, 223, 22, 133),),
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
                ElevatedButton(onPressed: ()async{
                 
                if(keyform.currentState!.validate() ) {
                
                  await cupit.Forgetpassword(email.text.trim());
                  
                 
                  
                }
                }, child: Text("send your email")),
                state is loadingforg?CircularProgressIndicator(color: const Color.fromARGB(255, 183, 232, 255),):Text(""),
                state is sucssforg?Text("تم إرسال رابط استعادة كلمة المرور إلى بريدك الإلكتروني",style: TextStyle(color: const Color.fromARGB(255, 235, 242, 255),backgroundColor: Colors.greenAccent),)
                :Text(""),
                state is errorforg?Text("مشكله في الارسال",style: TextStyle(color: const Color.fromARGB(255, 255, 154, 147)),):Text(""),
                
                TextButton(onPressed: (){
                  Navigator.pop(context);

                }, child: Text("login")),
                TextButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){return Registers();}));

                }, child: Text("do not have user")),
                 ])
                 
                
                  
                )
            ),
         ))  ; }  
    );
  }

  String get newMethod => "save";
}