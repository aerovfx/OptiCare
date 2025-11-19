import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../backend_services/payment_service/payment_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../navigation/bottom_nav_bar.dart';

/// Màn hình E-Claim - Tự động tính toán và thanh toán
class EClaimScreen extends ConsumerStatefulWidget {
  const EClaimScreen({super.key});

  @override
  ConsumerState<EClaimScreen> createState() => _EClaimScreenState();
}

class _EClaimScreenState extends ConsumerState<EClaimScreen> {
  double _totalAmount = 0.0;
  Map<String, dynamic>? _paymentResult;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Claim'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Lịch sử thanh toán
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              _buildHeaderCard(),
              
              const SizedBox(height: 16),
              
              // Input Total Amount
              _buildSectionTitle('Tổng chi phí'),
              const SizedBox(height: 10),
              _buildAmountInput(),
              
              if (_totalAmount > 0) ...[
                const SizedBox(height: 16),
                _buildSectionTitle('Phân bổ Thanh toán'),
                const SizedBox(height: 10),
                _buildBreakdownCard(),
                const SizedBox(height: 16),
                _buildProcessButton(),
              ],
              
              if (_paymentResult != null) ...[
                const SizedBox(height: 16),
                _buildResultCard(),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.secondaryGreen.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.secondaryGreen.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, color: AppTheme.secondaryGreen, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'E-Claim Tự động',
                  style: GoogleFonts.montserrat(
                    color: AppTheme.secondaryGreen,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Tự động trừ BHYT & Bảo hiểm Thương mại',
            style: GoogleFonts.montserrat(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.secondaryGreen.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, color: AppTheme.secondaryGreen, size: 16),
                const SizedBox(width: 6),
                Text(
                  'Minh bạch & Tự động',
                  style: GoogleFonts.montserrat(
                    color: AppTheme.secondaryGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAmountInput() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Nhập tổng chi phí (VNĐ)',
        prefixIcon: const Icon(Icons.attach_money),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        suffixText: 'VNĐ',
      ),
      onChanged: (value) {
        setState(() {
          _totalAmount = double.tryParse(value) ?? 0.0;
          _paymentResult = null;
        });
      },
    );
  }

  Widget _buildBreakdownCard() {
    if (_totalAmount <= 0) return const SizedBox.shrink();

    final bhytAmount = _totalAmount * 0.8;
    final commercialAmount = _totalAmount * 0.15;
    final remainingAmount = _totalAmount - bhytAmount - commercialAmount;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildBreakdownItem(
              'BHYT chi trả',
              bhytAmount,
              Icons.local_hospital,
              Colors.blue,
            ),
            const Divider(),
            _buildBreakdownItem(
              'Bảo hiểm Thương mại',
              commercialAmount,
              Icons.shield,
              Colors.purple,
            ),
            const Divider(),
            _buildBreakdownItem(
              'Còn lại',
              remainingAmount,
              Icons.account_balance_wallet,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng cộng:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${_formatCurrency(_totalAmount)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownItem(
    String label,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Text(
            _formatCurrency(amount),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessButton() {
    return ElevatedButton.icon(
      onPressed: _isProcessing ? null : _processPayment,
      icon: _isProcessing
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.payment),
      label: Text(_isProcessing ? 'Đang xử lý...' : 'Xử lý Thanh toán'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _processPayment() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final result = await PaymentService.processAutoPayment(
        appointmentId: 'APT-${DateTime.now().millisecondsSinceEpoch}',
        totalAmount: _totalAmount,
        userId: 'user-123', // TODO: Get from auth
      );

      setState(() {
        _paymentResult = result;
        _isProcessing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thanh toán thành công!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildResultCard() {
    if (_paymentResult == null) return const SizedBox.shrink();

    return Card(
      elevation: 4,
      color: Colors.green[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.green, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 32),
                SizedBox(width: 12),
                Text(
                  'Thanh toán Thành công',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildResultItem(
              'BHYT đã trừ',
              _formatCurrency(_paymentResult!['bhyt_claimed'] as double),
            ),
            _buildResultItem(
              'Bảo hiểm Thương mại đã trừ',
              _formatCurrency(_paymentResult!['commercial_insurance_claimed'] as double),
            ),
            if ((_paymentResult!['remaining_amount'] as double) > 0)
              _buildResultItem(
                'Đã thanh toán',
                _formatCurrency(_paymentResult!['remaining_amount'] as double),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    return '${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )} VNĐ';
  }
}

