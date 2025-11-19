import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'app_router.dart';

/// Thanh Điều hướng Dưới cùng - Chuyển đổi giữa các màn hình chính
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  
  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppTheme.primaryColor,
      unselectedItemColor: Colors.grey[400],
      backgroundColor: Colors.white,
      elevation: 0,
      selectedFontSize: 12,
      unselectedFontSize: 11,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
      ),
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, AppRouter.home);
            break;
          case 1:
            Navigator.pushReplacementNamed(context, AppRouter.screening);
            break;
          case 2:
            Navigator.pushReplacementNamed(context, AppRouter.appointment);
            break;
          case 3:
            Navigator.pushReplacementNamed(context, AppRouter.profile);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: 'Sàng lọc',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Lịch hẹn',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Hồ sơ',
        ),
      ],
    );
  }
}

