import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/constants/app_constants.dart';

/// Tích hợp API Bảo hiểm - E-Claim
class InsuranceAPIService {
  /// Claim BHYT
  static Future<Map<String, dynamic>> claimBHYT({
    required String userId,
    required double amount,
    required String appointmentId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/api/v1/insurance/bhyt/claim'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'amount': amount,
          'appointment_id': appointmentId,
        }),
      ).timeout(AppConstants.connectionTimeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Lỗi claim BHYT: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback
      return {
        'success': false,
        'claimed_amount': 0.0,
        'message': 'Lỗi: $e',
      };
    }
  }

  /// Claim Bảo hiểm Thương mại
  static Future<Map<String, dynamic>> claimCommercialInsurance({
    required String userId,
    required double amount,
    required String appointmentId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/api/v1/insurance/commercial/claim'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'amount': amount,
          'appointment_id': appointmentId,
        }),
      ).timeout(AppConstants.connectionTimeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Lỗi claim bảo hiểm thương mại: ${response.statusCode}');
      }
    } catch (e) {
      return {
        'success': false,
        'claimed_amount': 0.0,
        'message': 'Lỗi: $e',
      };
    }
  }
}

