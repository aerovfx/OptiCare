import 'package:flutter/material.dart';

/// AR Chỉ Đường Trong Bệnh Viện - Mũi tên ảo 3D lớn, liên tục di chuyển
class HospitalNavigationARScreen extends StatefulWidget {
  const HospitalNavigationARScreen({super.key});

  @override
  State<HospitalNavigationARScreen> createState() =>
      _HospitalNavigationARScreenState();
}

class _HospitalNavigationARScreenState
    extends State<HospitalNavigationARScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Chỉ Đường Bệnh Viện'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.navigation, size: 80, color: Colors.grey),
            SizedBox(height: 24),
            Text(
              'AR Chỉ Đường - Coming soon',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Mũi tên ảo 3D lớn, liên tục di chuyển\nđể điều hướng trong bệnh viện',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

