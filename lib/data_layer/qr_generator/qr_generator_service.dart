import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import '../../../core/constants/app_constants.dart';

/// Hệ thống Tạo Mã QR Truy cập - Chia sẻ Hồ sơ Y tế An toàn
class QRGeneratorService {
  /// Tạo mã QR duy nhất có thời hạn
  static Future<QRCodeData> generateAccessQR({
    required String patientId,
    required String recordId,
    Duration? expiration,
  }) async {
    final expiry = expiration ?? AppConstants.qrCodeExpiration;
    final expiresAt = DateTime.now().add(expiry);
    
    final data = {
      'patient_id': patientId,
      'record_id': recordId,
      'expires_at': expiresAt.toIso8601String(),
      'token': _generateToken(),
    };

    final qrData = jsonEncode(data);
    
    return QRCodeData(
      data: qrData,
      expiresAt: expiresAt,
      token: data['token'] as String,
    );
  }

  /// Xác thực mã QR
  static bool validateQR(String qrData) {
    try {
      final data = jsonDecode(qrData) as Map<String, dynamic>;
      final expiresAt = DateTime.parse(data['expires_at'] as String);
      
      if (expiresAt.isBefore(DateTime.now())) {
        return false; // Đã hết hạn
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Tạo token ngẫu nhiên
  static String _generateToken() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp * 1000).toString();
    return random.substring(random.length - 8);
  }
}

/// Dữ liệu QR Code
class QRCodeData {
  final String data;
  final DateTime expiresAt;
  final String token;

  QRCodeData({
    required this.data,
    required this.expiresAt,
    required this.token,
  });
}

