import 'package:flutter/foundation.dart';

/// Utility class for logging
class Logger {
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[DEBUG] $message');
      if (error != null) {
        print('[ERROR] $error');
        if (stackTrace != null) {
          print('[STACK] $stackTrace');
        }
      }
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      print('[INFO] $message');
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      print('[WARNING] $message');
    }
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[ERROR] $message');
      if (error != null) {
        print('[ERROR DETAIL] $error');
        if (stackTrace != null) {
          print('[STACK] $stackTrace');
        }
      }
    }
  }
}

