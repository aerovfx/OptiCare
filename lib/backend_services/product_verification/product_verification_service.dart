import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/constants/app_constants.dart';
import '../../../data_layer/database/product_database/product_database_service.dart';

/// Microservice AI Truy Xuất Nguồn Gốc & Xác Thực
class ProductVerificationService {
  /// Xác thực sản phẩm bằng Barcode/QR Code/Lot Number
  static Future<Map<String, dynamic>> verifyProduct(String identifier) async {
    try {
      // 1. Trích xuất mã nhận dạng từ hình ảnh (nếu cần)
      // Sử dụng Thị giác Máy tính (CV) và OCR
      final extractedCode = await _extractCodeFromImage(identifier);

      // 2. Đối chiếu với CSDL
      final productInfo = await ProductDatabaseService.getProductInfo(
        extractedCode,
      );

      if (productInfo == null) {
        return {
          'isValid': false,
          'status': 'Không tìm thấy sản phẩm',
          'warning': 'Sản phẩm không có trong hệ thống. Cảnh báo!',
        };
      }

      // 3. Kiểm tra tính hợp lệ
      final isValid = _validateProduct(productInfo);

      return {
        'isValid': isValid,
        'productName': productInfo['name'],
        'lotNumber': productInfo['lot_number'],
        'manufacturer': productInfo['manufacturer'],
        'expiryDate': productInfo['expiry_date'],
        'status': isValid ? 'Hợp lệ' : 'Không hợp lệ',
        'warning': isValid ? null : 'Cảnh báo: Sản phẩm có vấn đề!',
        'details': productInfo,
      };
    } catch (e) {
      return {
        'isValid': false,
        'status': 'Lỗi xác thực',
        'warning': 'Không thể xác thực sản phẩm: $e',
      };
    }
  }

  /// Trích xuất mã từ hình ảnh (CV + OCR)
  static Future<String> _extractCodeFromImage(String input) async {
    // Nếu input là URL hoặc base64 image, xử lý OCR
    // TODO: Implement OCR service
    return input; // Tạm thời trả về input
  }

  /// Xác thực tính hợp lệ của sản phẩm
  static bool _validateProduct(Map<String, dynamic> productInfo) {
    // Kiểm tra:
    // 1. Hạn sử dụng
    final expiryDate = DateTime.parse(productInfo['expiry_date']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    // 2. Giấy phép
    if (productInfo['license_status'] != 'active') {
      return false;
    }

    // 3. Lô hàng
    if (productInfo['lot_status'] != 'verified') {
      return false;
    }

    return true;
  }
}

