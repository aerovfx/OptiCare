import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/constants/app_constants.dart';

/// Tích hợp API Thanh toán - Ví điện tử/Ngân hàng
class PaymentAPIService {
  /// Xử lý thanh toán
  static Future<Map<String, dynamic>> processPayment({
    required double amount,
    required String userId,
    required String method, // 'wallet', 'bank', 'card'
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/api/v1/payment/process'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'amount': amount,
          'method': method,
        }),
      ).timeout(AppConstants.connectionTimeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Lỗi thanh toán: ${response.statusCode}');
      }
    } catch (e) {
      return {
        'success': false,
        'transaction_id': null,
        'message': 'Lỗi: $e',
      };
    }
  }
}

