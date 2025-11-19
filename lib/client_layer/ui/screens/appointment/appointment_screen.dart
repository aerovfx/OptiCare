import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend_services/appointment_service/appointment_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../navigation/bottom_nav_bar.dart';

/// Màn hình Bốc số Online & AI Dự báo Giờ Khám
class AppointmentScreen extends ConsumerStatefulWidget {
  const AppointmentScreen({super.key});

  @override
  ConsumerState<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends ConsumerState<AppointmentScreen> {
  String? _selectedDepartment;
  String? _selectedDoctor;
  DateTime? _selectedDate;
  Map<String, dynamic>? _queueInfo;
  DateTime? _predictedTime;
  bool _isLoading = false;

  final List<String> _departments = [
    'Khoa Tim mạch',
    'Khoa Nội tổng quát',
    'Khoa Ngoại',
    'Khoa Nhi',
    'Khoa Sản',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bốc số Online'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Lịch sử đặt lịch
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
              // Header với thông tin nổi bật
              _buildHeaderCard(),
              
              const SizedBox(height: 16),
              
              // Chọn khoa
              _buildSectionTitle('Chọn khoa'),
              const SizedBox(height: 10),
              _buildDepartmentSelector(),
              
              if (_selectedDepartment != null) ...[
                const SizedBox(height: 16),
                _buildSectionTitle('Chọn bác sĩ'),
                const SizedBox(height: 10),
                _buildDoctorSelector(),
              ],
              
              if (_selectedDoctor != null) ...[
                const SizedBox(height: 16),
                _buildSectionTitle('Chọn ngày'),
                const SizedBox(height: 10),
                _buildDateSelector(),
              ],
              
              if (_selectedDate != null && !_isLoading) ...[
                const SizedBox(height: 16),
                _buildGetQueueButton(),
              ],
              
              if (_queueInfo != null) ...[
                const SizedBox(height: 16),
                _buildQueueInfoCard(),
              ],
              
              if (_predictedTime != null) ...[
                const SizedBox(height: 12),
                _buildPredictionCard(),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
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
              Icon(Icons.qr_code_scanner, color: AppTheme.accentColor, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Bốc số Online',
                  style: TextStyle(
                    color: AppTheme.accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Không cần chờ đợi, không xếp hàng',
            style: TextStyle(
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
                Icon(Icons.psychology, color: AppTheme.accentColor, size: 16),
                const SizedBox(width: 6),
                Text(
                  'AI Dự báo giờ khám chính xác',
                  style: TextStyle(color: AppTheme.accentColor, fontSize: 12),
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

  Widget _buildDepartmentSelector() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _departments.map((dept) {
        final isSelected = _selectedDepartment == dept;
        return ChoiceChip(
          label: Text(dept),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedDepartment = selected ? dept : null;
              _selectedDoctor = null;
              _selectedDate = null;
              _queueInfo = null;
              _predictedTime = null;
            });
          },
          selectedColor: AppTheme.primaryColor,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDoctorSelector() {
    // Mock doctors list
    final doctors = ['BS. Nguyễn Văn A', 'BS. Trần Thị B', 'BS. Lê Văn C'];
    
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Chọn bác sĩ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.person),
      ),
      value: _selectedDoctor,
      items: doctors.map((doctor) {
        return DropdownMenuItem(
          value: doctor,
          child: Text(doctor),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedDoctor = value;
          _selectedDate = null;
          _queueInfo = null;
          _predictedTime = null;
        });
      },
    );
  }

  Widget _buildDateSelector() {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
        );
        if (date != null) {
          setState(() {
            _selectedDate = date;
            _queueInfo = null;
            _predictedTime = null;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 12),
            Text(
              _selectedDate != null
                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                  : 'Chọn ngày khám',
              style: TextStyle(
                fontSize: 16,
                color: _selectedDate != null ? Colors.black87 : Colors.grey,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildGetQueueButton() {
    return ElevatedButton.icon(
      onPressed: _getQueueNumber,
      icon: const Icon(Icons.qr_code),
      label: const Text('Bốc số Online'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _getQueueNumber() async {
    if (_selectedDepartment == null || _selectedDoctor == null || _selectedDate == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Lấy số thứ tự
      final queueInfo = await AppointmentService.getQueueNumber(
        doctorId: _selectedDoctor!,
        departmentId: _selectedDepartment!,
      );

      // AI Dự báo giờ khám
      final predictedTime = await AppointmentService.predictAppointmentTime(
        appointmentId: 'APT-${DateTime.now().millisecondsSinceEpoch}',
        scheduledTime: _selectedDate!,
      );

      setState(() {
        _queueInfo = queueInfo;
        _predictedTime = predictedTime;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    }
  }

  Widget _buildQueueInfoCard() {
    if (_queueInfo == null) return const SizedBox.shrink();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppTheme.accentColor.withOpacity(0.08),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.accentColor.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Số thứ tự của bạn',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_queueInfo!['queue_number']}',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w600,
                color: AppTheme.accentColor,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQueueStat(
                  'Đang phục vụ',
                  '${_queueInfo!['current_serving']}',
                  Icons.person,
                ),
                _buildQueueStat(
                  'Trước bạn',
                  '${_queueInfo!['total_ahead']}',
                  Icons.people,
                ),
                _buildQueueStat(
                  'Thời gian chờ',
                  '${_queueInfo!['estimated_wait_time']} phút',
                  Icons.access_time,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.accentColor, size: 20),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppTheme.accentColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildPredictionCard() {
    if (_predictedTime == null) return const SizedBox.shrink();

    final timeStr = '${_predictedTime!.hour.toString().padLeft(2, '0')}:${_predictedTime!.minute.toString().padLeft(2, '0')}';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppTheme.accentColor.withOpacity(0.08),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.accentColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.psychology, color: AppTheme.accentColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Dự báo giờ khám',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.accentColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Dự kiến: $timeStr',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
