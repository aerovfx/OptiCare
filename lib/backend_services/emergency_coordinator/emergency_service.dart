import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data_layer/database/ehr_database/ehr_database_service.dart';

/// Microservice AI Điều phối Khẩn cấp (SOS)
class EmergencyService {
  /// Kích hoạt luồng cấp cứu khẩn cấp
  static Future<void> activateEmergency({
    required Position location,
    required BuildContext context,
  }) async {
    try {
      // 1. Tự động phân loại tình trạng khẩn cấp dựa trên EHR
      final ehrData = await EHRDatabaseService.getLatestEHR();
      final emergencyLevel = _classifyEmergency(ehrData);

      // 2. Điều động xe cấp cứu gần nhất
      await _dispatchAmbulance(location, emergencyLevel);

      // 3. Gửi thông báo khẩn cấp đến Bệnh viện phù hợp
      await _notifyHospital(location, emergencyLevel, ehrData);

      // 4. Hiển thị thông tin cho người dùng
      if (context.mounted) {
        _showEmergencyInfo(context, location, emergencyLevel);
      }

      // 5. Gọi hotline tự động (nếu có thể)
      await _callEmergencyHotline();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi kích hoạt cấp cứu: $e')),
        );
      }
    }
  }

  /// Phân loại mức độ khẩn cấp dựa trên EHR
  static String _classifyEmergency(Map<String, dynamic>? ehrData) {
    if (ehrData == null) return 'medium';

    // Logic phân loại dựa trên dữ liệu EHR
    // Ví dụ: Nếu có tiền sử tim mạch -> cao
    final medicalHistory = ehrData['medical_history'] ?? [];
    if (medicalHistory.contains('heart_disease')) {
      return 'high';
    }
    return 'medium';
  }

  /// Điều động xe cấp cứu
  static Future<void> _dispatchAmbulance(
    Position location,
    String emergencyLevel,
  ) async {
    // Gọi API để tìm xe cấp cứu gần nhất
    // TODO: Implement API call
  }

  /// Thông báo đến bệnh viện
  static Future<void> _notifyHospital(
    Position location,
    String emergencyLevel,
    Map<String, dynamic>? ehrData,
  ) async {
    // Gửi thông tin đến bệnh viện phù hợp
    // TODO: Implement API call
  }

  /// Hiển thị thông tin cấp cứu
  static void _showEmergencyInfo(
    BuildContext context,
    Position location,
    String emergencyLevel,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Đã kích hoạt Cấp cứu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mức độ: ${_getEmergencyLevelText(emergencyLevel)}'),
            const SizedBox(height: 8),
            Text('Vị trí: ${location.latitude}, ${location.longitude}'),
            const SizedBox(height: 8),
            const Text('Xe cấp cứu đang được điều động...'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Gọi hotline cấp cứu
  static Future<void> _callEmergencyHotline() async {
    final uri = Uri.parse('tel:${AppConstants.emergencyHotline}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static String _getEmergencyLevelText(String level) {
    switch (level) {
      case 'high':
        return 'Cao';
      case 'medium':
        return 'Trung bình';
      case 'low':
        return 'Thấp';
      default:
        return 'Không xác định';
    }
  }
}

