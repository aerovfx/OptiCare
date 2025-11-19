import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Thẻ Sức Khỏe Cá Nhân - Hiển thị tóm tắt chỉ số và thông báo cá nhân hóa
class HealthCardWidget extends StatelessWidget {
  const HealthCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.primaryColor.withOpacity(0.15),
              AppTheme.primaryLight.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.primaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thẻ Sức Khỏe Cá Nhân',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.health_and_safety, color: AppTheme.primaryColor, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            
            // Tóm tắt chỉ số - Grid layout
            Row(
              children: [
                Expanded(
                  child: _buildHealthMetric(
                    'Nhịp tim',
                    '72 bpm',
                    Icons.favorite,
                    Colors.red.shade300,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildHealthMetric(
                    'Huyết áp',
                    '120/80',
                    Icons.monitor_heart,
                    Colors.blue.shade300,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildHealthMetric(
                    'SpO₂',
                    '98%',
                    Icons.air,
                    Colors.green.shade300,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            Divider(color: AppTheme.primaryColor.withOpacity(0.2), height: 1),
            const SizedBox(height: 10),
            
            // Thông báo cá nhân hóa
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.notifications_active, color: AppTheme.primaryColor, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Lịch khám: 15/01/2024 - 09:00',
                      style: TextStyle(color: AppTheme.primaryColor, fontSize: 12),
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

  Widget _buildHealthMetric(String label, String value, IconData icon, Color iconColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: AppTheme.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

