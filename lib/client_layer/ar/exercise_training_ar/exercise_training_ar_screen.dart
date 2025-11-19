import 'package:flutter/material.dart';

/// AR Huấn luyện Tập luyện - Phủ mô hình xương/khớp ảo để sửa lỗi tư thế
class ExerciseTrainingARScreen extends StatefulWidget {
  const ExerciseTrainingARScreen({super.key});

  @override
  State<ExerciseTrainingARScreen> createState() =>
      _ExerciseTrainingARScreenState();
}

class _ExerciseTrainingARScreenState extends State<ExerciseTrainingARScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Huấn luyện Tập luyện'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 80, color: Colors.grey),
            SizedBox(height: 24),
            Text(
              'AR Tập luyện - Coming soon',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Phủ mô hình xương/khớp ảo lên người dùng\nđể sửa lỗi tư thế real-time',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

