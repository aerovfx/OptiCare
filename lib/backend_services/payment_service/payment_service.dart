import '../../../core/constants/app_constants.dart';
import '../../../data_layer/external_apis/insurance_api/insurance_api_service.dart';
import '../../../data_layer/external_apis/payment_api/payment_api_service.dart';

/// Microservice Thanh toán Tự động (E-Claim)
class PaymentService {
  /// Xử lý thanh toán tự động với BHYT và Bảo hiểm Thương mại
  static Future<Map<String, dynamic>> processAutoPayment({
    required String appointmentId,
    required double totalAmount,
    required String userId,
  }) async {
    try {
      // 1. Tính toán chi phí tổng
      final breakdown = _calculateCostBreakdown(totalAmount);

      // 2. Tự động trừ Phần BHYT
      final bhytAmount = breakdown['bhyt_amount'] as double;
      await InsuranceAPIService.claimBHYT(
        userId: userId,
        amount: bhytAmount,
        appointmentId: appointmentId,
      );

      // 3. Tự động trừ Phần Bảo hiểm Thương mại
      final commercialAmount = breakdown['commercial_amount'] as double;
      await InsuranceAPIService.claimCommercialInsurance(
        userId: userId,
        amount: commercialAmount,
        appointmentId: appointmentId,
      );

      // 4. Tính phần còn lại (nếu có)
      final remainingAmount = breakdown['remaining_amount'] as double;

      // 5. Xử lý thanh toán cuối cùng (nếu có)
      Map<String, dynamic>? finalPaymentResult;
      if (remainingAmount > 0) {
        finalPaymentResult = await PaymentAPIService.processPayment(
          amount: remainingAmount,
          userId: userId,
          method: 'wallet', // hoặc 'bank'
        );
      }

      return {
        'success': true,
        'total_amount': totalAmount,
        'bhyt_claimed': breakdown['bhyt_amount'],
        'commercial_insurance_claimed': breakdown['commercial_amount'],
        'remaining_amount': remainingAmount,
        'final_payment': finalPaymentResult,
        'breakdown': breakdown,
      };
    } catch (e) {
      throw Exception('Lỗi xử lý thanh toán: $e');
    }
  }

  /// Tính toán phân bổ chi phí
  static Map<String, double> _calculateCostBreakdown(double totalAmount) {
    // Logic tính toán dựa trên quy định BHYT
    // Ví dụ: BHYT chi trả 80%, Bảo hiểm thương mại 15%, Còn lại 5%
    final bhytAmount = totalAmount * 0.8;
    final commercialAmount = totalAmount * 0.15;
    final remainingAmount = totalAmount - bhytAmount - commercialAmount;

    return {
      'bhyt_amount': bhytAmount,
      'commercial_amount': commercialAmount,
      'remaining_amount': remainingAmount,
    };
  }

  /// Lấy lịch sử thanh toán
  static Future<List<Map<String, dynamic>>> getPaymentHistory({
    required String userId,
  }) async {
    try {
      // TODO: Implement API call
      return [];
    } catch (e) {
      throw Exception('Lỗi lấy lịch sử thanh toán: $e');
    }
  }
}

