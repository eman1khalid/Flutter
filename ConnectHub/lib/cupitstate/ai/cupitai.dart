import 'package:ConnectHub/cupitstate/ai/statesai.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class Cupitai extends Cubit<Statesai> {
  Cupitai() : super(Intialstateai());
  
  final Dio _dio = Dio(); 
  final List<Map<String, String>> messages = [];
  final String apiKey = "AQ.Ab8RN6ICmBmiKX29gfeHI4hm8H7sJWnBp9PLbaAu1djQPp8h1A"; 

  Future<void> getPostIdea(String userPrompt) async {
    messages.add({"sender": "user", "text": userPrompt});
    emit(Waitingresponce());

   try {
  final String url ="https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent?key=$apiKey";
  print("FULL URL: $url");
  Response response = await _dio.post(
    url,
    data: {
      "contents": [
        {
          "parts": [
            {
              "text": "انت مساعد لتوليد افكار منشورات فقط، لو سالت عن موضوع غير المنشورات ارفض الاجابه. السؤال: $userPrompt"
            }
          ]
        }
      ]
    },
  );

  if (response.statusCode == 200) {
    final data = response.data;
    String aiReply = data['candidates']?[0]?['content']?['parts']?[0]?['text'] ?? "لم يتم استخراج الرد.";
    
    messages.add({"sender": "ai", "text": aiReply});
    emit(Sucssfulresponce());
    
  } else {
    emit(Serverconnectionfailed());
    messages.add({"sender": "ai", "text": "فشل الاتصال بالخادم."});
  }
  
} on DioException catch (e) {
  print("STATUS CODE: ${e.response?.statusCode}");
  print("ERROR BODY: ${e.response?.data}");
  emit(Networkconnectionfailed());
  messages.add({"sender": "ai", "text": "حدث خطأ في الشبكة: ${e.message}"});
}
  }
}