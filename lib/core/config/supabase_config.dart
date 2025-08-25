import 'package:supabase_flutter/supabase_flutter.dart';

/// Advanced Supabase configuration and constants
class SupabaseConfig {
  // Private constructor
  SupabaseConfig._();

  /// Database table names
  static const String usersTable = 'users';
  static const String profilesTable = 'profiles';

  /// Storage bucket names
  static const String avatarsBucket = 'avatars';
  static const String filesBucket = 'files';
  static const String publicBucket = 'public';

  /// Real-time channel names
  static const String globalChannel = 'global';
  static const String userChannel = 'user_channel';

  /// Database function names
  static const String getUserProfileFunction = 'get_user_profile';
  static const String updateUserStatsFunction = 'update_user_stats';

  /// Authentication configuration
  static const AuthFlowType authFlow = AuthFlowType.pkce;
  static const bool persistSession = true;
  static const Duration authTimeout = Duration(seconds: 30);

  /// File upload constraints
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = [
    'image/jpeg',
    'image/png',
    'image/gif',
    'image/webp',
  ];
  static const List<String> allowedDocumentTypes = [
    'application/pdf',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  ];

  /// API endpoints for edge functions
  static const String sendNotificationFunction = 'send-notification';
  static const String processPaymentFunction = 'process-payment';
  static const String generateReportFunction = 'generate-report';

  /// Real-time event types
  static const String insertEvent = 'INSERT';
  static const String updateEvent = 'UPDATE';
  static const String deleteEvent = 'DELETE';

  /// Common database policies
  static const String userPolicyName = 'Users can manage their own data';
  static const String adminPolicyName = 'Admin can manage all data';
  static const String publicReadPolicyName = 'Public read access';

  /// Session management
  static const Duration sessionRefreshInterval = Duration(minutes: 55);
  static const Duration maxSessionDuration = Duration(hours: 24);

  /// Error retry configuration
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  /// Helper methods for common queries
  static String getUserQuery(String userId) {
    return '''
      SELECT *
      FROM $profilesTable
      WHERE user_id = '$userId'
    ''';
  }

  static Map<String, dynamic> getUserFilter(String userId) {
    return {'user_id': userId};
  }

  static Map<String, dynamic> getActiveFilter() {
    return {'is_active': true};
  }

  /// Storage helper methods
  static String getAvatarPath(String userId) {
    return '$avatarsBucket/$userId/avatar.jpg';
  }

  static String getFilePath(String userId, String fileName) {
    return '$filesBucket/$userId/$fileName';
  }

  /// Validation helpers
  static bool isValidFileSize(int fileSize) {
    return fileSize <= maxFileSize;
  }

  static bool isValidImageType(String mimeType) {
    return allowedImageTypes.contains(mimeType.toLowerCase());
  }

  static bool isValidDocumentType(String mimeType) {
    return allowedDocumentTypes.contains(mimeType.toLowerCase());
  }
}

/// Supabase response extensions
extension SupabaseResponseExtension on PostgrestResponse {
  // ignore: unnecessary_null_comparison
  bool get isSuccess => error == null;
  bool get hasData => data != null && (data as List).isNotEmpty;
}

mixin error {}

/// Supabase error types
enum SupabaseErrorType {
  network,
  authentication,
  authorization,
  validation,
  server,
  unknown,
}

/// Supabase error handler
class SupabaseErrorHandler {
  static SupabaseErrorType getErrorType(Object error) {
    if (error is AuthException) {
      return SupabaseErrorType.authentication;
    } else if (error is PostgrestException) {
      if (error.code == 'PGRST116') {
        return SupabaseErrorType.authorization;
      }
      return SupabaseErrorType.server;
    } else {
      return SupabaseErrorType.unknown;
    }
  }

  static String getErrorMessage(Object error) {
    final errorType = getErrorType(error);

    switch (errorType) {
      case SupabaseErrorType.authentication:
        return 'Kimlik doğrulama hatası. Lütfen tekrar giriş yapın.';
      case SupabaseErrorType.authorization:
        return 'Bu işlem için yetkiniz bulunmuyor.';
      case SupabaseErrorType.validation:
        return 'Girdiğiniz bilgiler geçersiz.';
      case SupabaseErrorType.network:
        return 'İnternet bağlantınızı kontrol edin.';
      case SupabaseErrorType.server:
        return 'Sunucu hatası. Lütfen daha sonra tekrar deneyin.';
      case SupabaseErrorType.unknown:
        return 'Beklenmeyen bir hata oluştu.';
    }
  }
}
