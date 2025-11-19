/// Model Lịch Hẹn
class AppointmentModel {
  final String appointmentId;
  final String doctorId;
  final String doctorName;
  final String departmentId;
  final String departmentName;
  final DateTime scheduledTime;
  final DateTime? predictedTime;
  final String status;
  final String? reason;
  final int? queueNumber;

  AppointmentModel({
    required this.appointmentId,
    required this.doctorId,
    required this.doctorName,
    required this.departmentId,
    required this.departmentName,
    required this.scheduledTime,
    this.predictedTime,
    required this.status,
    this.reason,
    this.queueNumber,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      appointmentId: json['appointment_id'] as String,
      doctorId: json['doctor_id'] as String,
      doctorName: json['doctor_name'] as String,
      departmentId: json['department_id'] as String,
      departmentName: json['department_name'] as String,
      scheduledTime: DateTime.parse(json['scheduled_time'] as String),
      predictedTime: json['predicted_time'] != null
          ? DateTime.parse(json['predicted_time'] as String)
          : null,
      status: json['status'] as String,
      reason: json['reason'] as String?,
      queueNumber: json['queue_number'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointment_id': appointmentId,
      'doctor_id': doctorId,
      'doctor_name': doctorName,
      'department_id': departmentId,
      'department_name': departmentName,
      'scheduled_time': scheduledTime.toIso8601String(),
      'predicted_time': predictedTime?.toIso8601String(),
      'status': status,
      'reason': reason,
      'queue_number': queueNumber,
    };
  }
}

