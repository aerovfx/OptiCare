import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'custom_icons/custom_health_icons.dart';

/// Grid hiển thị các Module chức năng chính
class ModuleGridWidget extends StatelessWidget {
  const ModuleGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chức năng',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
          children: [
            // Bốc số Online & AI Dự báo
            _buildModuleCard(
              context,
              'Bốc số Online',
              null,
              AppTheme.accentColor,
              () => Navigator.pushNamed(context, '/appointment'),
              subtitle: 'AI Dự báo giờ khám',
              customIcon: CustomHealthIcons.qrCodeScanner(color: AppTheme.accentColor, size: 20),
            ),
            // Sàng Lọc AI đa chiều
            _buildModuleCard(
              context,
              'Sàng Lọc AI',
              null,
              AppTheme.secondaryGreen,
              () => Navigator.pushNamed(context, '/screening'),
              subtitle: 'Hình ảnh, Âm thanh',
              customIcon: CustomHealthIcons.aiScreening(color: AppTheme.secondaryGreen, size: 20),
            ),
            // Giám sát Nội trú
            _buildModuleCard(
              context,
              'Giám sát Nội trú',
              null,
              AppTheme.accentColor,
              () => Navigator.pushNamed(context, '/monitoring'),
              subtitle: 'Cảnh báo tức thời',
              customIcon: CustomHealthIcons.heartMonitor(color: AppTheme.accentColor, size: 20),
            ),
            // AR Chỉ đường
            _buildModuleCard(
              context,
              'AR Chỉ đường',
              null,
              AppTheme.primaryColor,
              () => Navigator.pushNamed(context, '/ar-navigation'),
              subtitle: 'Trong bệnh viện',
              customIcon: CustomHealthIcons.navigation(color: AppTheme.primaryColor, size: 20),
            ),
            // AR Hướng dẫn
            _buildModuleCard(
              context,
              'AR Hướng dẫn',
              null,
              AppTheme.orange,
              () => Navigator.pushNamed(context, '/ar-guide'),
              subtitle: 'Sơ cứu & Tập luyện',
              customIcon: CustomHealthIcons.arGuide(color: AppTheme.orange, size: 20),
            ),
            // E-Claim
            _buildModuleCard(
              context,
              'E-Claim',
              null,
              AppTheme.secondaryGreen,
              () => Navigator.pushNamed(context, '/eclaim'),
              subtitle: 'Tự động thanh toán',
              customIcon: CustomHealthIcons.payment(color: AppTheme.secondaryGreen, size: 20),
            ),
            // Xác thực Thuốc
            _buildModuleCard(
              context,
              'Xác thực Thuốc',
              null,
              AppTheme.teal,
              () => Navigator.pushNamed(context, '/product-verify'),
              subtitle: 'Quét & Truy xuất',
              customIcon: CustomHealthIcons.verified(color: AppTheme.teal, size: 20),
            ),
            // Chatbot 24/7
            _buildModuleCard(
              context,
              'Chatbot Y tế',
              null,
              AppTheme.blue,
              () => Navigator.pushNamed(context, '/chatbot'),
              subtitle: 'Hỗ trợ 24/7',
              customIcon: CustomHealthIcons.chatbot(color: AppTheme.blue, size: 20),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModuleCard(
    BuildContext context,
    String title,
    IconData? icon,
    Color color,
    VoidCallback onTap, {
    String? subtitle,
    Widget? customIcon,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: color.withOpacity(0.08),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: color.withOpacity(0.1),
          highlightColor: color.withOpacity(0.05),
            child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: customIcon ?? (icon != null ? Icon(icon, color: color, size: 20) : const SizedBox()),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: color,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

