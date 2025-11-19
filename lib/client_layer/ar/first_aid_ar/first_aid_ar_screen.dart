import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// AR Hướng dẫn Sơ cứu - Phủ mô hình 3D ảo (ví dụ: vị trí ấn khi CPR)
class FirstAidARScreen extends StatefulWidget {
  const FirstAidARScreen({super.key});

  @override
  State<FirstAidARScreen> createState() => _FirstAidARScreenState();
}

class _FirstAidARScreenState extends State<FirstAidARScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Hướng dẫn Sơ cứu'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.view_in_ar, size: 80, color: Colors.grey),
            SizedBox(height: 24),
            Text(
              'AR Sơ cứu - Coming soon',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Phủ mô hình 3D ảo lên màn hình\ntheo yêu cầu của tổng đài viên',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

