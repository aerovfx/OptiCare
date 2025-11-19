import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/screening/screening_screen.dart';
import '../screens/appointment/appointment_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/emergency/emergency_screen.dart';
import '../screens/monitoring/monitoring_screen.dart';
import '../screens/eclaim/eclaim_screen.dart';
import '../../camera/product_scanner/product_scanner_screen.dart';
import '../../ar/hospital_navigation_ar/hospital_navigation_ar_screen.dart';
import '../../ar/first_aid_ar/first_aid_ar_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String screening = '/screening';
  static const String appointment = '/appointment';
  static const String profile = '/profile';
  static const String emergency = '/emergency';
  static const String monitoring = '/monitoring';
  static const String eclaim = '/eclaim';
  static const String productVerify = '/product-verify';
  static const String arNavigation = '/ar-navigation';
  static const String arGuide = '/ar-guide';
  static const String chatbot = '/chatbot';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case screening:
        return MaterialPageRoute(builder: (_) => const ScreeningScreen());
      case appointment:
        return MaterialPageRoute(builder: (_) => const AppointmentScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case emergency:
        return MaterialPageRoute(builder: (_) => const EmergencyScreen());
      case monitoring:
        return MaterialPageRoute(builder: (_) => const MonitoringScreen());
      case eclaim:
        return MaterialPageRoute(builder: (_) => const EClaimScreen());
      case productVerify:
        return MaterialPageRoute(builder: (_) => const ProductScannerScreen());
      case arNavigation:
        return MaterialPageRoute(builder: (_) => const HospitalNavigationARScreen());
      case arGuide:
        return MaterialPageRoute(builder: (_) => const FirstAidARScreen());
      case chatbot:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Chatbot Y tế')),
            body: const Center(
              child: Text('Chatbot Y tế - Coming soon'),
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route ${settings.name} not found'),
            ),
          ),
        );
    }
  }
}

