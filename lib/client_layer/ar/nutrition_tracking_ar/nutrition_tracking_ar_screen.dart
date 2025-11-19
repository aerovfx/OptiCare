import 'package:flutter/material.dart';

/// AR Theo dõi Dinh dưỡng - Quét món ăn và ước tính Calo/Carb/Protein
class NutritionTrackingARScreen extends StatefulWidget {
  const NutritionTrackingARScreen({super.key});

  @override
  State<NutritionTrackingARScreen> createState() =>
      _NutritionTrackingARScreenState();
}

class _NutritionTrackingARScreenState extends State<NutritionTrackingARScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Theo dõi Dinh dưỡng'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, size: 80, color: Colors.grey),
            SizedBox(height: 24),
            Text(
              'AR Dinh dưỡng - Coming soon',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Quét món ăn và ước tính\nCalo/Carb/Protein',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

