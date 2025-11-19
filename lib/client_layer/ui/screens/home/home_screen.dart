import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../emergency/emergency_screen.dart';
import '../../widgets/health_account_banner.dart';
import '../../widgets/quick_actions_row.dart';
import '../../widgets/favorite_functions_grid.dart';
import '../../widgets/promotional_cards.dart';
import '../../navigation/bottom_nav_bar.dart';

/// Màn Hình Chính - Thiết kế theo phong cách ngân hàng nhưng cho bệnh viện
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Y Tế - Sức Khỏe Của Bạn',
          style: GoogleFonts.montserrat(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.grey[700]),
            onPressed: () {
              // Notifications
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header với greeting
              _buildHeader(context),
              
              // Health Account Banner (tương tự Account Banner trong ngân hàng)
              const HealthAccountBanner(),
              
              const SizedBox(height: 16),
              
              // Quick Actions Row
              const QuickActionsRow(),
              
              const SizedBox(height: 24),
              
              // Favorite Functions Section
              const FavoriteFunctionsGrid(),
              
              const SizedBox(height: 24),
              
              // Promotional Cards
              const PromotionalCards(),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: AppTheme.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Xin chào,',
                  style: GoogleFonts.montserrat(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'DANG VIET CHUNG',
                  style: GoogleFonts.montserrat(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey[700]),
            onPressed: () {
              // Search
            },
          ),
        ],
      ),
    );
  }
}
