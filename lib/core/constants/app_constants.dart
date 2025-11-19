class AppConstants {
  // API Endpoints
  static const String baseUrl = 'https://api.yte.vn';
  static const String aiScreeningEndpoint = '/api/v1/ai/screening';
  static const String emergencyEndpoint = '/api/v1/emergency';
  static const String appointmentEndpoint = '/api/v1/appointments';
  static const String productVerificationEndpoint = '/api/v1/products/verify';
  
  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // AR Configuration
  static const double arMarkerSize = 0.1; // meters
  static const double arNavigationArrowScale = 2.0;
  
  // Camera Configuration
  static const int maxImageSize = 1920;
  static const double imageCompressionQuality = 0.8;
  
  // Location
  static const double locationUpdateInterval = 5.0; // seconds
  static const double locationAccuracy = 10.0; // meters
  
  // Emergency
  static const String emergencyHotline = '115';
  static const int sosButtonHoldDuration = 3; // seconds
  
  // Cache
  static const Duration cacheExpiration = Duration(hours: 24);
  
  // QR Code
  static const Duration qrCodeExpiration = Duration(hours: 1);
}

