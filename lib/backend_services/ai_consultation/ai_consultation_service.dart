import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/constants/app_constants.dart';

/// Microservice Tư vấn AI - Chatbot Y tế Chuyên sâu (LLM Y khoa)
class AIConsultationService {
  /// Gửi câu hỏi đến Chatbot Y tế
  static Future<Map<String, dynamic>> askQuestion({
    required String question,
    String? context, // Thông tin bối cảnh từ EHR
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/api/v1/ai/consultation'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'question': question,
          'context': context,
          'model': 'medical_llm',
        }),
      ).timeout(AppConstants.connectionTimeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Lỗi tư vấn: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback response
      return {
        'answer': 'Xin lỗi, tôi không thể trả lời câu hỏi này lúc này. '
            'Vui lòng liên hệ bác sĩ để được tư vấn chuyên sâu hơn.',
        'confidence': 0.0,
        'sources': [],
        'recommendation': 'Nên tham khảo ý kiến bác sĩ',
      };
    }
  }

  /// Hướng dẫn sơ cứu
  static Future<Map<String, dynamic>> getFirstAidGuide({
    required String situation,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/api/v1/ai/first_aid'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'situation': situation,
        }),
      ).timeout(AppConstants.connectionTimeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Lỗi lấy hướng dẫn: ${response.statusCode}');
      }
    } catch (e) {
      return {
        'steps': [
          'Giữ bình tĩnh',
          'Gọi cấp cứu 115',
          'Thực hiện sơ cứu theo hướng dẫn',
        ],
        'warning': 'Đây chỉ là hướng dẫn cơ bản. Luôn ưu tiên gọi cấp cứu.',
      };
    }
  }
}

