import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import 'custom_icons/custom_health_icons.dart';

/// Favorite Functions Grid - Tương tự "Chức năng ưa thích" trong ngân hàng
class FavoriteFunctionsGrid extends StatelessWidget {
  const FavoriteFunctionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chức năng ưa thích',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {
                  // View all
                },
                child: Text(
                  'Xem tất cả',
                  style: GoogleFonts.montserrat(
                    color: AppTheme.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Grid 4 columns
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
            children: [
              _buildFunctionItem(
                context,
                'Bốc số Online',
                CustomHealthIcons.qrCodeScanner(color: AppTheme.primaryColor, size: 24),
                AppTheme.primaryColor,
                () => Navigator.pushNamed(context, '/appointment'),
              ),
              _buildFunctionItem(
                context,
                'Sàng Lọc AI',
                CustomHealthIcons.aiScreening(color: AppTheme.secondaryGreen, size: 24),
                AppTheme.secondaryGreen,
                () => Navigator.pushNamed(context, '/screening'),
              ),
              _buildFunctionItem(
                context,
                'Giám sát',
                CustomHealthIcons.heartMonitor(color: AppTheme.accentColor, size: 24),
                AppTheme.accentColor,
                () => Navigator.pushNamed(context, '/monitoring'),
              ),
              _buildFunctionItem(
                context,
                'AR Y tế',
                CustomHealthIcons.arGuide(color: AppTheme.orange, size: 24),
                AppTheme.orange,
                () => Navigator.pushNamed(context, '/ar-guide'),
              ),
              _buildFunctionItem(
                context,
                'E-Claim',
                CustomHealthIcons.payment(color: AppTheme.secondaryGreen, size: 24),
                AppTheme.secondaryGreen,
                () => Navigator.pushNamed(context, '/eclaim'),
              ),
              _buildFunctionItem(
                context,
                'Xác thực',
                CustomHealthIcons.verified(color: AppTheme.teal, size: 24),
                AppTheme.teal,
                () => Navigator.pushNamed(context, '/product-verify'),
              ),
              _buildFunctionItem(
                context,
                'Chatbot',
                CustomHealthIcons.chatbot(color: AppTheme.blue, size: 24),
                AppTheme.blue,
                () => Navigator.pushNamed(context, '/chatbot'),
              ),
              _buildFunctionItem(
                context,
                'Cấp cứu',
                Icon(Icons.emergency, color: AppTheme.emergencyRed, size: 24),
                AppTheme.emergencyRed,
                () => Navigator.pushNamed(context, '/emergency'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFunctionItem(
    BuildContext context,
    String label,
    Widget icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

