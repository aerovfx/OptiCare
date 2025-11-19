import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Tích hợp Bản đồ & GPS - Tính toán thời gian đi lại
class MapsAPIService {
  /// Tính toán thời gian đi lại (bao gồm giao thông)
  static Future<int> calculateTravelTime({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  }) async {
    try {
      // Sử dụng Google Maps API để tính toán
      // TODO: Implement Google Maps Directions API
      
      // Fallback: Tính khoảng cách đơn giản
      final distance = Geolocator.distanceBetween(
        startLat,
        startLon,
        endLat,
        endLon,
      );

      // Giả định tốc độ trung bình 30 km/h trong thành phố
      final timeInMinutes = (distance / 1000 / 30 * 60).round();
      
      // Thêm buffer cho giao thông
      return timeInMinutes + 10;
    } catch (e) {
      return 30; // Default 30 minutes
    }
  }

  /// Lấy chỉ đường
  static Future<List<LatLng>> getDirections({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  }) async {
    // TODO: Implement Google Maps Directions API
    return [
      LatLng(startLat, startLon),
      LatLng(endLat, endLon),
    ];
  }
}

