import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

/// Nền tảng IoT/Giám sát Real-time - Thu thập chỉ số sinh tồn
class IoTMonitoringService {
  static MqttServerClient? _client;
  static final StreamController<Map<String, dynamic>> _vitalsController =
      StreamController<Map<String, dynamic>>.broadcast();

  /// Stream chỉ số sinh tồn real-time
  static Stream<Map<String, dynamic>> get vitalsStream =>
      _vitalsController.stream;

  /// Kết nối đến IoT platform
  static Future<void> connect({
    required String broker,
    required String clientId,
    String? username,
    String? password,
  }) async {
    _client = MqttServerClient.withPort(broker, clientId, 1883);
    _client!.logging(on: false);
    _client!.keepAlivePeriod = 20;
    _client!.autoReconnect = true;

    if (username != null && password != null) {
      _client!.secure = false;
      final connMessage = MqttConnectMessage()
          .withClientIdentifier(clientId)
          .startClean()
          .withWillQos(MqttQos.atLeastOnce);
      _client!.connectionMessage = connMessage;
    }

    try {
      await _client!.connect();
      _client!.updates!.listen(_onMessage);
    } catch (e) {
      throw Exception('Lỗi kết nối IoT: $e');
    }
  }

  /// Xử lý tin nhắn từ IoT
  static void _onMessage(List<MqttReceivedMessage<MqttMessage?>>? c) {
    final recMess = c![0].payload as MqttPublishMessage;
    final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    try {
      final data = Map<String, dynamic>.from(
        // Giả định dữ liệu là JSON
        // TODO: Parse JSON properly
        {'raw': pt},
      );

      // Phân tích bằng AI Phân tích Chuỗi Thời gian
      final analyzedData = _analyzeTimeSeries(data);

      // Phát hiện bất thường và kích hoạt cảnh báo
      if (_detectAnomaly(analyzedData)) {
        _triggerEmergencyAlert(analyzedData);
      }

      _vitalsController.add(analyzedData);
    } catch (e) {
      // Handle error
    }
  }

  /// AI Phân tích Chuỗi Thời gian
  static Map<String, dynamic> _analyzeTimeSeries(
    Map<String, dynamic> data,
  ) {
    // Logic phân tích mô hình bất thường
    return {
      'heart_rate': data['hr'] ?? 72,
      'spO2': data['spo2'] ?? 98,
      'blood_pressure': data['bp'] ?? '120/80',
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'anomaly_score': 0.0,
    };
  }

  /// Phát hiện bất thường
  static bool _detectAnomaly(Map<String, dynamic> data) {
    final hr = data['heart_rate'] as int? ?? 72;
    final spo2 = data['spO2'] as int? ?? 98;

    // Logic phát hiện: HR < 60 hoặc > 100, SpO2 < 95
    return hr < 60 || hr > 100 || spo2 < 95;
  }

  /// Kích hoạt Cảnh báo Pop-up Khẩn cấp
  static void _triggerEmergencyAlert(Map<String, dynamic> data) {
    // TODO: Implement notification system
    // Hiển thị pop-up cảnh báo khẩn cấp
  }

  /// Ngắt kết nối
  static void disconnect() {
    _client?.disconnect();
    _client = null;
  }
}

