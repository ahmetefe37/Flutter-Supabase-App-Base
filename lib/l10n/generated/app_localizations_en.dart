// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Supa Sample';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get name => 'Name';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get signOut => 'Sign Out';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get home => 'Home';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get nameHint => 'Enter your name';

  @override
  String get loginTitle => 'Welcome Back';

  @override
  String get loginSubtitle => 'Sign in to your account';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get registerSubtitle => 'Create a new account';

  @override
  String get validationEmailRequired => 'Email is required';

  @override
  String get validationEmailInvalid => 'Enter a valid email address';

  @override
  String get validationPasswordRequired => 'Password is required';

  @override
  String get validationPasswordTooShort =>
      'Password must be at least 6 characters';

  @override
  String get validationPasswordMismatch => 'Passwords do not match';

  @override
  String get validationNameRequired => 'Name is required';

  @override
  String get errorsGeneral => 'An error occurred. Please try again.';

  @override
  String get errorsNetwork => 'Check your internet connection.';

  @override
  String get errorsInvalidCredentials => 'Invalid email or password';

  @override
  String get errorsUserNotFound => 'User not found';

  @override
  String get errorsEmailAlreadyExists => 'Email already exists';

  @override
  String get errorsWeakPassword => 'Password is too weak';

  @override
  String get successLoginSuccess => 'Login successful';

  @override
  String get successRegisterSuccess => 'Registration successful';

  @override
  String get successProfileUpdated => 'Profile updated successfully';

  @override
  String get successPasswordResetSent => 'Password reset email sent';

  @override
  String get buttonsSave => 'Save';

  @override
  String get buttonsCancel => 'Cancel';

  @override
  String get buttonsDelete => 'Delete';

  @override
  String get buttonsEdit => 'Edit';

  @override
  String get buttonsUpdate => 'Update';

  @override
  String get buttonsUpload => 'Upload';

  @override
  String get buttonsDownload => 'Download';

  @override
  String get buttonsRetry => 'Retry';

  @override
  String get buttonsOk => 'OK';

  @override
  String get buttonsYes => 'Yes';

  @override
  String get buttonsNo => 'No';

  @override
  String greetingWithName(String name) {
    return 'Hello, $name!';
  }

  @override
  String itemCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString items',
      one: 'One item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String lastSeen(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Last seen $dateString';
  }

  @override
  String fileSize(double size) {
    final intl.NumberFormat sizeNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String sizeString = sizeNumberFormat.format(size);

    return '$sizeString MB';
  }

  @override
  String get languagesEn => 'English';

  @override
  String get languagesTr => 'Türkçe';

  @override
  String get languagesEs => 'Español';

  @override
  String get languagesFr => 'Français';

  @override
  String get languagesDe => 'Deutsch';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';
}
