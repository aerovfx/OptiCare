import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../client_layer/location/gps_tracker/gps_tracker_service.dart';
import '../../../../backend_services/emergency_coordinator/emergency_service.dart';

/// Màn hình Cấp Cứu Khẩn Cấp - Luồng Cấp cứu 24/24
class EmergencyScreen extends ConsumerStatefulWidget {
  final bool isEmergency;
  
  const EmergencyScreen({
    super.key,
    this.isEmergency = false,
  });

  @override
  ConsumerState<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends ConsumerState<EmergencyScreen> {
  bool _isActive = false;
  String? _currentLocation;

  @override
  void initState() {
    super.initState();
    if (widget.isEmergency) {
      _activateEmergency();
    }
  }

  Future<void> _activateEmergency() async {
    setState(() {
      _isActive = true;
    });

    // Lấy vị trí real-time
    final location = await GPSTrackerService.getCurrentLocation();
    setState(() {
      _currentLocation = '${location.latitude}, ${location.longitude}';
    });

    // Gọi dịch vụ cấp cứu
    await EmergencyService.activateEmergency(
      location: location,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.emergencyRed,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: const Row(
                children: [
                  Icon(Icons.emergency, color: Colors.white, size: 32),
                  SizedBox(width: 12),
                  Text(
                    'CẤP CỨU KHẨN CẤP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Status
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isActive) ...[
                      const CircularProgressIndicator(color: Colors.white),
                      const SizedBox(height: 24),
                      const Text(
                        'Đang kết nối với tổng đài...',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      if (_currentLocation != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Vị trí: $_currentLocation',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ] else ...[
                      ElevatedButton(
                        onPressed: _activateEmergency,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.emergencyRed,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 24,
                          ),
                        ),
                        child: const Text(
                          'KÍCH HOẠT CẤP CỨU',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Hotline: 115',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

