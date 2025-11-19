import 'package:flutter/material.dart';
import '../../navigation/bottom_nav_bar.dart';
import '../../../security/biometric_auth/biometric_auth_service.dart';

/// Màn hình Hồ Sơ - Yêu cầu Xác thực Sinh trắc học
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    final authenticated = await BiometricAuthService.authenticate(
      reason: 'Xác thực để truy cập hồ sơ y tế',
    );
    setState(() {
      _isAuthenticated = authenticated;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) {
      return Scaffold(
        appBar: AppBar(title: const Text('Hồ Sơ')),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ Sơ'),
      ),
      body: const Center(
        child: Text('Hồ Sơ Y Tế - Coming soon'),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}

