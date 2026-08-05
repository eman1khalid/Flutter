import 'package:app2/cupitstate/cupit.dart';
import 'package:app2/cupitstate/states.dart';
import 'package:app2/pages/notepage.dart';
import 'package:app2/pages/reg.dart';
import 'package:flutter/material.dart';
import 'package:app2/pages/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart'; // تأكد من إضافة مكتبة uuid أو استخدام الطريقة البديلة

class massege extends StatefulWidget {
  const massege({super.key});

  @override
  State<massege> createState() => _massegeState();
}

class _massegeState extends State<massege> {
  final GlobalKey<FormState> keyform = GlobalKey<FormState>();
  final TextEditingController massegeController = TextEditingController(); 
  bool isLoading = false;
  
  // توليد معرف جلسة فريد وثابت أثناء فتح الصفحة
  final String sessionId = const Uuid().v4();

  // قائمة لحفظ رسائل الشات (سواء رسالة المستخدم أو رد الـ AI)
  final List<Map<String, String>> messages = [];

  Future<void> sendToN8n(String textMessage) async {
    if (textMessage.trim().isEmpty) return;

    // إضافة رسالة المستخدم فوراً للقائمة لعرضها
    setState(() {
      messages.add({"sender": "user", "text": textMessage});
      isLoading = true;
    });

    massegeController.clear();

    final url = Uri.parse('https://emanffhd.app.n8n.cloud/webhook/f1852915-16e4-4423-9785-9fb4767a60e3');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': textMessage,
          'session_id': sessionId, 
        }),
      );

      if (response.statusCode == 200) {
        // فك تشفير الـ JSON واستخراج مفتاح "reply" فقط كما طلب في الأسايمنت
        final data = response.body;
        String aiReply = data ?? "لا يوجد رد";

        setState(() {
          messages.add({"sender": "ai", "text": aiReply});
          isLoading = false;
        });
      } else {
        setState(() {
          messages.add({"sender": "ai", "text": "Error: ${response.statusCode}"});
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        messages.add({"sender": "ai", "text": "Failed: $e"});
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cubitclass, States>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Customer Support"),
            centerTitle: true,
            foregroundColor: const Color.fromARGB(255, 223, 22, 133),
            backgroundColor: const Color.fromARGB(84, 223, 22, 133),
          ),
          body: Column(
            children: [
              // قسم عرض المحادثات القديمة والجديدة بحيث تظل ظاهرة
              Expanded(
                child: messages.isEmpty
                    ? const Center(
                        child: Text(
                          "اسالنا",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          final isUser = msg["sender"] == "user";
                          return Align(
                            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isUser ? Colors.pink.shade100 : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                msg["text"] ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isUser ? Colors.black87 : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // مؤشر التحميل أثناء انتظار الرد
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(color: Colors.pink),
                ),

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
                      onPressed: isLoading ? null : () => sendToN8n(massegeController.text),
                      icon: const Icon(Icons.send, color: Colors.pink),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}