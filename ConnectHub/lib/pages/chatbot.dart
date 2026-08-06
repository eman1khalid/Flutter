import 'package:ConnectHub/cupitstate/ai/cupitai.dart';
import 'package:ConnectHub/cupitstate/ai/statesai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart' show Uuid; // تأكد من إضافة مكتبة uuid أو استخدام الطريقة البديلة

class chatpot extends StatefulWidget {
  const chatpot({super.key});

  @override
  State<chatpot> createState() => _chatpotState();
}

class _chatpotState extends State<chatpot> {
  final GlobalKey<FormState> keyform = GlobalKey<FormState>();
  final TextEditingController massegeController = TextEditingController(); 
  bool isLoading = false;
  
  // توليد معرف جلسة فريد وثابت أثناء فتح الصفحة
  final String sessionId = const Uuid().v4();

  // قائمة لحفظ رسائل الشات (سواء رسالة المستخدم أو رد الـ AI)
  

  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder <Cupitai,Statesai>(builder: (context,state){
  
        return Scaffold(
          appBar: AppBar(
            title: const Text("AI Chatbot🤖"),
            centerTitle: true,
            foregroundColor: const Color.fromARGB(255, 164, 21, 235),
            backgroundColor: const Color.fromARGB(82, 89, 22, 223),
          ),
          body: Column(
            children: [
              // قسم عرض المحادثات القديمة والجديدة بحيث تظل ظاهرة
              Expanded(
                child: BlocProvider.of<Cupitai>(context).messages.isEmpty
                    ? const Center(
                        child: Text(
                          "اسالنا",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: BlocProvider.of<Cupitai>(context).messages.length,
                        itemBuilder: (context, index) {
                          final msg = BlocProvider.of<Cupitai>(context).messages[index];
                          final isUser = msg["sender"] == "user";
                          return Align(
                            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isUser ? const Color.fromARGB(255, 255, 198, 254) : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                msg["text"] ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
             state is Waitingresponce?
                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(color: Colors.pink),
                )
              :
              state is Serverconnectionfailed?
               Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(children: [
                    Icon(Icons.cloud_off),
                    SizedBox(height: 16,),
                    Text("فشل الاتصال بالخادم",style: TextStyle(color: Colors.red) ,textAlign: TextAlign.center,)
                  ],),
                )
              :
               (state is Networkconnectionfailed)?
                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(children: [
                    Icon(Icons.cloud_off),
                    SizedBox(height: 16,),
                    Text("يرجى التحقق من اتصال الإنترنت والمحاولة مرة أخرى",style: TextStyle(color: Colors.red) ,textAlign: TextAlign.center,)
                  ],),
                ):Text("") ,            
              // مؤشر التحميل أثناء انتظار الرد
              
              // صندوق الإدخال وزر الإرسال في الأسفل
               Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: massegeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          label: const Text("message"),
                          hintText: "please enter message",
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: state is Waitingresponce ? null : () { 
                        var textt=massegeController.text.trim();
                        if(textt.isEmpty)return;
                         BlocProvider.of<Cupitai>(context).getPostIdea (textt);
                         massegeController.clear();},
                         
                      icon: const Icon(Icons.send, color: Color.fromARGB(255, 199, 30, 233)),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        );
      });
  }
  }
