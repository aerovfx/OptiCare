/// Model Cấp Cứu Khẩn Cấp
class EmergencyModel {
  final String emergencyId;
  final String userId;
  final double latitude;
  final double longitude;
  final String emergencyLevel;
  final DateTime timestamp;
  final String? status;
  final String? ambulanceId;

  EmergencyModel({
    required this.emergencyId,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.emergencyLevel,
    required this.timestamp,
    this.status,
    this.ambulanceId,
  });

  factory EmergencyModel.fromJson(Map<String, dynamic> json) {
    return EmergencyModel(
      emergencyId: json['emergency_id'] as String,
      userId: json['user_id'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      emergencyLevel: json['emergency_level'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String?,
      ambulanceId: json['ambulance_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emergency_id': emergencyId,
      'user_id': userId,
      'latitude': latitude,
      'longitude': longitude,
      'emergency_level': emergencyLevel,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'ambulance_id': ambulanceId,
    };
  }
}

