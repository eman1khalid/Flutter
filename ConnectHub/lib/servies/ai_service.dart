import 'package:dio/dio.dart';

class AIService {
  
  final Dio _dio = Dio();

  
  final String apiKey = "AQ.Ab8RN6JfQDaH2eWSBzdgx0yTlq-1hqEthiPZhKiDCGuZuq8PUg";

  
  Future<String> getPostIdea(String userPrompt) async {
    try {
      // رابط الـ API الخاص بالنموذج
      final String url = "https://generativelanguage.googleapis.com/v1beta/interactions?key=${apiKey}";

      // 2. إرسال الطلب (POST Request) باستخدام Dio
      Response response = await _dio.post(
        url,
        data: {
          {
    "model": "models/gemini-3-flash-preview",
    "input": "انت مساعد لتوليد افكار مشورات فقط لو سالت عن موضوع غير المنشورات ارفض الاجابه وسؤال هو:${userPrompt}",
    "tools": [
        {
            "type": "google_search"
        }
    ],
    "generation_config": {
        "temperature": 1,
        "max_output_tokens": 65536,
        "top_p": 0.95,
        "thinking_level": "high"
    }
}
        },
      );

      // 3. التحقق من نجاح الاستجابة واستخراج النص
      if (response.statusCode == 200) {
        final data = response.data;
        
        // استخراج رد الذكاء الاصطناعي من هيكل البيانات الراجع
        String aiReply = data['candidates'][0]['content']['parts'][0]['text'];
        return aiReply;
      } else {
        return "فشل الاتصال بالخادم.";
      }
    } on DioException catch (e) {
      // التعامل مع أخطاء الشبكة عبر Dio بكل سهولة
      return "حدث خطأ في الشبكة: ${e.message}";
    }
  }
}