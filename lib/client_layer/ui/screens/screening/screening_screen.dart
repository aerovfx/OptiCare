import 'package:flutter/material.dart';
import '../../../camera/ai_screening_camera/ai_screening_camera_screen.dart';
import '../../navigation/bottom_nav_bar.dart';

/// Màn hình Sàng Lọc AI
class ScreeningScreen extends StatelessWidget {
  const ScreeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sàng Lọc AI'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt, size: 80, color: Colors.grey),
            const SizedBox(height: 24),
            const Text(
              'Sàng lọc Ung thư da & Nốt ruồi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AIScreeningCameraScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.camera),
              label: const Text('Bắt đầu Chụp ảnh'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}

