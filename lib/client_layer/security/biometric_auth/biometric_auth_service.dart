import 'package:local_auth/local_auth.dart';

/// Service xác thực sinh trắc học (Vân tay/Face ID)
class BiometricAuthService {
  static final LocalAuthentication _auth = LocalAuthentication();

  /// Kiểm tra xem thiết bị có hỗ trợ sinh trắc học không
  static Future<bool> isAvailable() async {
    try {
      return await _auth.canCheckBiometrics ||
          await _auth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  /// Xác thực bằng sinh trắc học
  static Future<bool> authenticate({
    required String reason,
    bool useErrorDialogs = true,
    bool stickyAuth = true,
  }) async {
    try {
      final isAvailable = await BiometricAuthService.isAvailable();
      if (!isAvailable) {
        return false;
      }

      return await _auth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth,
        ),
      );
    } catch (e) {
      return false;
    }
  }

  /// Lấy danh sách các phương thức sinh trắc học có sẵn
  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }
}

