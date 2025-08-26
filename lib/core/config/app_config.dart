import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  // App Constants
  static const String appName = 'Supa Sample';
  static const String appVersion = '1.0.0';

  // Development/Production mode
  static bool get isDevelopment => kDebugMode;
  static bool get isProduction => kReleaseMode;

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';

  // Validation
  static bool get isConfigValid => supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
