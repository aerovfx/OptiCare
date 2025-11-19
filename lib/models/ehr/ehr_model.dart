/// Model Hồ sơ Y tế Điện tử (EHR)
class EHRModel {
  final String recordId;
  final String patientId;
  final String recordType;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  EHRModel({
    required this.recordId,
    required this.patientId,
    required this.recordType,
    required this.data,
    required this.timestamp,
  });

  factory EHRModel.fromJson(Map<String, dynamic> json) {
    return EHRModel(
      recordId: json['record_id'] as String,
      patientId: json['patient_id'] as String,
      recordType: json['record_type'] as String,
      data: json['data'] as Map<String, dynamic>,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'record_id': recordId,
      'patient_id': patientId,
      'record_type': recordType,
      'data': data,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

