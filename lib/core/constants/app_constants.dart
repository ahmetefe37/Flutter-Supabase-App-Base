class AppConstants {
  // Route Names
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
  static const String forgotPasswordRoute = '/forgot-password';

  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration splashDelay = Duration(seconds: 2);

  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultBorderRadius = 12.0;

  // Error Messages
  static const String defaultErrorMessage =
      'An error occurred. Please try again.';
  static const String networkErrorMessage =
      'Please check your internet connection.';
  static const String invalidEmailMessage =
      'Please enter a valid email address.';
  static const String weakPasswordMessage =
      'Password must be at least 6 characters long.';
  static const String passwordMismatchMessage = 'Passwords do not match.';
}
