import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data_layer/iot/monitoring/iot_monitoring_service.dart';
import '../../navigation/bottom_nav_bar.dart';

/// Màn hình Giám sát Nội trú - AI Giám sát liên tục, cảnh báo tức thời
class MonitoringScreen extends ConsumerStatefulWidget {
  const MonitoringScreen({super.key});

  @override
  ConsumerState<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends ConsumerState<MonitoringScreen> {
  Map<String, dynamic>? _currentVitals;
  bool _isMonitoring = false;
  List<Map<String, dynamic>> _alerts = [];

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  void _startMonitoring() {
    setState(() {
      _isMonitoring = true;
    });

    // Lắng nghe stream từ IoT Monitoring Service
    IoTMonitoringService.vitalsStream.listen((vitals) {
      setState(() {
        _currentVitals = vitals;
        
        // Kiểm tra cảnh báo
        if (_detectAnomaly(vitals)) {
          _addAlert(vitals);
        }
      });
    });
  }

  bool _detectAnomaly(Map<String, dynamic> vitals) {
    final hr = vitals['heart_rate'] as int? ?? 72;
    final spo2 = vitals['spO2'] as int? ?? 98;
    
    return hr < 60 || hr > 100 || spo2 < 95;
  }

  void _addAlert(Map<String, dynamic> vitals) {
    final alert = {
      'timestamp': DateTime.now(),
      'type': 'critical',
      'message': _getAlertMessage(vitals),
      'vitals': vitals,
    };
    
    setState(() {
      _alerts.insert(0, alert);
      if (_alerts.length > 10) {
        _alerts.removeLast();
      }
    });

    // Hiển thị pop-up cảnh báo
    _showEmergencyAlert(alert);
  }

  String _getAlertMessage(Map<String, dynamic> vitals) {
    final hr = vitals['heart_rate'] as int? ?? 72;
    final spo2 = vitals['spO2'] as int? ?? 98;
    
    if (hr < 60) {
      return 'Nhịp tim thấp bất thường: $hr bpm';
    } else if (hr > 100) {
      return 'Nhịp tim cao bất thường: $hr bpm';
    } else if (spo2 < 95) {
      return 'Nồng độ oxy máu thấp: $spo2%';
    }
    return 'Phát hiện chỉ số bất thường';
  }

  void _showEmergencyAlert(Map<String, dynamic> alert) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.emergencyRed,
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'CẢNH BÁO KHẨN CẤP',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        content: Text(
          alert['message'] as String,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/emergency');
            },
            child: const Text(
              'Gọi cấp cứu',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Đã biết',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giám sát Nội trú'),
        actions: [
          IconButton(
            icon: Icon(_isMonitoring ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _isMonitoring = !_isMonitoring;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              _buildHeaderCard(),
              
              const SizedBox(height: 16),
              
              // Vitals Display
              if (_currentVitals != null) ...[
                _buildSectionTitle('Chỉ số Sinh tồn Real-time'),
                const SizedBox(height: 10),
                _buildVitalsGrid(),
                const SizedBox(height: 16),
              ],
              
              // Alerts
              _buildSectionTitle('Cảnh báo Gần đây'),
              const SizedBox(height: 10),
              _buildAlertsList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.accentColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.accentColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.monitor_heart, color: AppTheme.accentColor, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'AI Giám sát Nội trú',
                  style: GoogleFonts.montserrat(
                    color: AppTheme.accentColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Theo dõi liên tục, cảnh báo tức thời',
            style: GoogleFonts.montserrat(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isMonitoring ? Icons.circle : Icons.circle_outlined,
                  color: AppTheme.accentColor,
                  size: 12,
                ),
                const SizedBox(width: 6),
                Text(
                  _isMonitoring ? 'Đang giám sát' : 'Tạm dừng',
                  style: GoogleFonts.montserrat(
                    color: AppTheme.accentColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildVitalsGrid() {
    if (_currentVitals == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        _buildVitalCard(
          'Nhịp tim',
          '${_currentVitals!['heart_rate']} bpm',
          Icons.favorite,
          Colors.red,
          _isVitalNormal('heart_rate', _currentVitals!['heart_rate']),
        ),
        _buildVitalCard(
          'SpO₂',
          '${_currentVitals!['spO2']}%',
          Icons.air,
          Colors.blue,
          _isVitalNormal('spO2', _currentVitals!['spO2']),
        ),
        _buildVitalCard(
          'Huyết áp',
          _currentVitals!['blood_pressure'] ?? '120/80',
          Icons.monitor_heart,
          Colors.purple,
          true,
        ),
      ],
    );
  }

  bool _isVitalNormal(String type, dynamic value) {
    if (type == 'heart_rate') {
      final hr = value as int;
      return hr >= 60 && hr <= 100;
    } else if (type == 'spO2') {
      final spo2 = value as int;
      return spo2 >= 95;
    }
    return true;
  }

  Widget _buildVitalCard(
    String label,
    String value,
    IconData icon,
    Color color,
    bool isNormal,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isNormal ? Colors.green : Colors.red,
          width: 2,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isNormal ? Colors.black87 : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertsList() {
    if (_alerts.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 48),
                const SizedBox(height: 12),
                const Text(
                  'Không có cảnh báo',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: _alerts.map((alert) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: AppTheme.emergencyRed.withOpacity(0.1),
          child: ListTile(
            leading: const Icon(Icons.warning, color: Colors.red),
            title: Text(
              alert['message'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              _formatTime(alert['timestamp'] as DateTime),
              style: const TextStyle(fontSize: 12),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Xem chi tiết cảnh báo
            },
          ),
        );
      }).toList(),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} - ${time.day}/${time.month}/${time.year}';
  }
}

