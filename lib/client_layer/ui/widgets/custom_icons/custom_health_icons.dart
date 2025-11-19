import 'package:flutter/material.dart';

/// Custom Health Icons - Line art style đơn giản
class CustomHealthIcons {
  /// Icon Bốc số Online - QR Code Scanner
  static Widget qrCodeScanner({Color? color, double? size}) {
    return CustomPaint(
      size: Size(size ?? 24, size ?? 24),
      painter: _QRCodePainter(color: color ?? Colors.blue),
    );
  }

  /// Icon Sàng Lọc AI - Camera với AI symbol
  static Widget aiScreening({Color? color, double? size}) {
    return CustomPaint(
      size: Size(size ?? 24, size ?? 24),
      painter: _AIScreeningPainter(color: color ?? Colors.green),
    );
  }

  /// Icon Giám sát Nội trú - Heart Monitor
  static Widget heartMonitor({Color? color, double? size}) {
    return CustomPaint(
      size: Size(size ?? 24, size ?? 24),
      painter: _HeartMonitorPainter(color: color ?? Colors.red),
    );
  }

  /// Icon AR Chỉ đường - Navigation Arrow
  static Widget navigation({Color? color, double? size}) {
    return CustomPaint(
      size: Size(size ?? 24, size ?? 24),
      painter: _NavigationPainter(color: color ?? Colors.purple),
    );
  }

  /// Icon AR Hướng dẫn - AR Symbol
  static Widget arGuide({Color? color, double? size}) {
    return CustomPaint(
      size: Size(size ?? 24, size ?? 24),
      painter: _ARGuidePainter(color: color ?? Colors.orange),
    );
  }

  /// Icon E-Claim - Payment/Card
  static Widget payment({Color? color, double? size}) {
    return CustomPaint(
      size: Size(size ?? 24, size ?? 24),
      painter: _PaymentPainter(color: color ?? Colors.green),
    );
  }

  /// Icon Xác thực Thuốc - Verified Shield
  static Widget verified({Color? color, double? size}) {
    return CustomPaint(
      size: Size(size ?? 24, size ?? 24),
      painter: _VerifiedPainter(color: color ?? Colors.teal),
    );
  }

  /// Icon Chatbot - Chat Bubble
  static Widget chatbot({Color? color, double? size}) {
    return CustomPaint(
      size: Size(size ?? 24, size ?? 24),
      painter: _ChatbotPainter(color: color ?? Colors.indigo),
    );
  }
}

// QR Code Painter
class _QRCodePainter extends CustomPainter {
  final Color color;

  _QRCodePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // QR Code pattern tối giản - chỉ đường nét mỏng
    // Top-left corner - đơn giản hóa
    canvas.drawRect(Rect.fromLTWH(w * 0.15, h * 0.15, w * 0.25, h * 0.25), paint);
    canvas.drawRect(Rect.fromLTWH(w * 0.2, h * 0.2, w * 0.15, h * 0.15), paint);
    
    // Bottom-right corner
    canvas.drawRect(Rect.fromLTWH(w * 0.6, h * 0.6, w * 0.25, h * 0.25), paint);
    canvas.drawRect(Rect.fromLTWH(w * 0.65, h * 0.65, w * 0.15, h * 0.15), paint);
    
    // Dots pattern - tối giản
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.45, h * 0.45), 1.5, paint);
    canvas.drawCircle(Offset(w * 0.55, h * 0.55), 1.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// AI Screening Painter - Camera với AI symbol
class _AIScreeningPainter extends CustomPainter {
  final Color color;

  _AIScreeningPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Camera body - tối giản
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.25, h * 0.25, w * 0.5, h * 0.5),
        const Radius.circular(2),
      ),
      paint,
    );
    
    // Lens - đơn giản
    canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.12, paint);
    
    // AI symbol - chỉ một đường cong mềm mại
    final aiPath = Path();
    aiPath.moveTo(w * 0.35, h * 0.35);
    aiPath.quadraticBezierTo(w * 0.5, h * 0.3, w * 0.65, h * 0.35);
    canvas.drawPath(aiPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Heart Monitor Painter
class _HeartMonitorPainter extends CustomPainter {
  final Color color;

  _HeartMonitorPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Heart shape tối giản - chỉ đường cong mềm mại
    final path = Path();
    path.moveTo(w * 0.5, h * 0.35);
    path.quadraticBezierTo(w * 0.25, h * 0.2, w * 0.2, h * 0.4);
    path.quadraticBezierTo(w * 0.2, h * 0.6, w * 0.5, h * 0.85);
    path.quadraticBezierTo(w * 0.8, h * 0.6, w * 0.8, h * 0.4);
    path.quadraticBezierTo(w * 0.75, h * 0.2, w * 0.5, h * 0.35);
    canvas.drawPath(path, paint);

    // ECG line - đơn giản hóa, mềm mại hơn
    final ecgPath = Path();
    ecgPath.moveTo(w * 0.15, h * 0.6);
    ecgPath.quadraticBezierTo(w * 0.3, h * 0.4, w * 0.45, h * 0.65);
    ecgPath.quadraticBezierTo(w * 0.6, h * 0.5, w * 0.85, h * 0.6);
    canvas.drawPath(ecgPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Navigation Painter - Arrow
class _NavigationPainter extends CustomPainter {
  final Color color;

  _NavigationPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Arrow tối giản - chỉ đường cong mềm mại
    final path = Path();
    path.moveTo(w * 0.5, h * 0.25);
    path.quadraticBezierTo(w * 0.3, h * 0.5, w * 0.4, h * 0.65);
    path.moveTo(w * 0.5, h * 0.25);
    path.quadraticBezierTo(w * 0.7, h * 0.5, w * 0.6, h * 0.65);
    path.moveTo(w * 0.4, h * 0.65);
    path.quadraticBezierTo(w * 0.5, h * 0.75, w * 0.6, h * 0.65);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// AR Guide Painter - AR Symbol
class _ARGuidePainter extends CustomPainter {
  final Color color;

  _ARGuidePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // AR frame tối giản - chỉ corner markers mềm mại
    final cornerSize = w * 0.2;
    
    // Top-left - đường cong
    final topLeftPath = Path();
    topLeftPath.moveTo(w * 0.25, h * 0.25);
    topLeftPath.quadraticBezierTo(w * 0.2, h * 0.2, w * 0.25, h * 0.2);
    topLeftPath.quadraticBezierTo(w * 0.2, h * 0.2, w * 0.2, h * 0.25);
    canvas.drawPath(topLeftPath, paint);
    
    // Top-right
    final topRightPath = Path();
    topRightPath.moveTo(w * 0.75, h * 0.25);
    topRightPath.quadraticBezierTo(w * 0.8, h * 0.2, w * 0.75, h * 0.2);
    topRightPath.quadraticBezierTo(w * 0.8, h * 0.2, w * 0.8, h * 0.25);
    canvas.drawPath(topRightPath, paint);
    
    // Bottom-left
    final bottomLeftPath = Path();
    bottomLeftPath.moveTo(w * 0.25, h * 0.75);
    bottomLeftPath.quadraticBezierTo(w * 0.2, h * 0.8, w * 0.25, h * 0.8);
    bottomLeftPath.quadraticBezierTo(w * 0.2, h * 0.8, w * 0.2, h * 0.75);
    canvas.drawPath(bottomLeftPath, paint);
    
    // Bottom-right
    final bottomRightPath = Path();
    bottomRightPath.moveTo(w * 0.75, h * 0.75);
    bottomRightPath.quadraticBezierTo(w * 0.8, h * 0.8, w * 0.75, h * 0.8);
    bottomRightPath.quadraticBezierTo(w * 0.8, h * 0.8, w * 0.8, h * 0.75);
    canvas.drawPath(bottomRightPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Payment Painter - Card
class _PaymentPainter extends CustomPainter {
  final Color color;

  _PaymentPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Card shape tối giản - bo tròn mềm mại
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.2, h * 0.25, w * 0.6, h * 0.5),
        const Radius.circular(6),
      ),
      paint,
    );

    // Chip - đơn giản hóa
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.3, h * 0.4, w * 0.12, h * 0.15),
        const Radius.circular(2),
      ),
      paint,
    );

    // Lines - mềm mại hơn
    paint.style = PaintingStyle.stroke;
    final linePath = Path();
    linePath.moveTo(w * 0.3, h * 0.65);
    linePath.quadraticBezierTo(w * 0.5, h * 0.63, w * 0.7, h * 0.65);
    canvas.drawPath(linePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Verified Painter - Shield with checkmark
class _VerifiedPainter extends CustomPainter {
  final Color color;

  _VerifiedPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Shield shape tối giản - đường cong mềm mại
    final shieldPath = Path();
    shieldPath.moveTo(w * 0.5, h * 0.15);
    shieldPath.quadraticBezierTo(w * 0.25, h * 0.3, w * 0.25, h * 0.6);
    shieldPath.quadraticBezierTo(w * 0.25, h * 0.8, w * 0.5, h * 0.85);
    shieldPath.quadraticBezierTo(w * 0.75, h * 0.8, w * 0.75, h * 0.6);
    shieldPath.quadraticBezierTo(w * 0.75, h * 0.3, w * 0.5, h * 0.15);
    canvas.drawPath(shieldPath, paint);

    // Checkmark - đường cong mềm mại
    final checkPath = Path();
    checkPath.moveTo(w * 0.38, h * 0.5);
    checkPath.quadraticBezierTo(w * 0.45, h * 0.55, w * 0.5, h * 0.6);
    checkPath.quadraticBezierTo(w * 0.58, h * 0.52, w * 0.62, h * 0.45);
    canvas.drawPath(checkPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Chatbot Painter - Chat bubble
class _ChatbotPainter extends CustomPainter {
  final Color color;

  _ChatbotPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Chat bubble tối giản - bo tròn mềm mại
    final bubblePath = Path();
    bubblePath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.15, h * 0.15, w * 0.6, h * 0.55),
        const Radius.circular(12),
      ),
    );
    // Tail - đường cong mềm mại
    final tailPath = Path();
    tailPath.moveTo(w * 0.25, h * 0.7);
    tailPath.quadraticBezierTo(w * 0.35, h * 0.65, w * 0.3, h * 0.75);
    tailPath.quadraticBezierTo(w * 0.28, h * 0.72, w * 0.25, h * 0.7);
    canvas.drawPath(tailPath, paint);
    canvas.drawPath(bubblePath, paint);

    // Dots (typing indicator) - nhỏ hơn, mềm mại
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.38, h * 0.42), 1.5, paint);
    canvas.drawCircle(Offset(w * 0.5, h * 0.42), 1.5, paint);
    canvas.drawCircle(Offset(w * 0.62, h * 0.42), 1.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

