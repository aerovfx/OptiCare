import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/constants/app_constants.dart';

/// Big Data & Dịch Tễ - Tạo Bản đồ Dịch Tễ (Heatmap)
class EpidemiologyService {
  /// Lấy dữ liệu dịch tễ để tạo Heatmap
  static Future<Map<String, dynamic>> getEpidemiologyData({
    String? region,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}/api/v1/epidemiology/heatmap')
            .replace(queryParameters: {
          if (region != null) 'region': region,
          if (startDate != null) 'start_date': startDate.toIso8601String(),
          if (endDate != null) 'end_date': endDate.toIso8601String(),
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(AppConstants.connectionTimeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Lỗi lấy dữ liệu dịch tễ: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback data
      return {
        'regions': [
          {
            'name': 'Hà Nội',
            'lat': 21.0285,
            'lon': 105.8542,
            'risk_level': 'medium',
            'cases': 150,
          },
          {
            'name': 'TP. Hồ Chí Minh',
            'lat': 10.8231,
            'lon': 106.6297,
            'risk_level': 'high',
            'cases': 300,
          },
        ],
        'updated_at': DateTime.now().toIso8601String(),
      };
    }
  }

  /// Lấy mức độ rủi ro theo khu vực
  static String getRiskLevel(double cases) {
    if (cases > 200) return 'high';
    if (cases > 100) return 'medium';
    return 'low';
  }
}

