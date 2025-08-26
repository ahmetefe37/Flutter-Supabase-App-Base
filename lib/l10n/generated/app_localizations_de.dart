// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Supa Sample';

  @override
  String get welcome => 'Willkommen';

  @override
  String get login => 'Anmelden';

  @override
  String get register => 'Registrieren';

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Passwort';

  @override
  String get confirmPassword => 'Passwort Bestätigen';

  @override
  String get name => 'Name';

  @override
  String get forgotPassword => 'Passwort Vergessen';

  @override
  String get resetPassword => 'Passwort Zurücksetzen';

  @override
  String get signOut => 'Abmelden';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Einstellungen';

  @override
  String get home => 'Startseite';

  @override
  String get emailHint => 'Geben Sie Ihre E-Mail ein';

  @override
  String get passwordHint => 'Geben Sie Ihr Passwort ein';

  @override
  String get nameHint => 'Geben Sie Ihren Namen ein';

  @override
  String get loginTitle => 'Willkommen Zurück';

  @override
  String get loginSubtitle => 'Melden Sie sich in Ihrem Konto an';

  @override
  String get registerTitle => 'Konto Erstellen';

  @override
  String get registerSubtitle => 'Erstellen Sie ein neues Konto';

  @override
  String get validationEmailRequired => 'E-Mail ist erforderlich';

  @override
  String get validationEmailInvalid =>
      'Geben Sie eine gültige E-Mail-Adresse ein';

  @override
  String get validationPasswordRequired => 'Passwort ist erforderlich';

  @override
  String get validationPasswordTooShort =>
      'Das Passwort muss mindestens 6 Zeichen haben';

  @override
  String get validationPasswordMismatch => 'Passwörter stimmen nicht überein';

  @override
  String get validationNameRequired => 'Name ist erforderlich';

  @override
  String get errorsGeneral =>
      'Ein Fehler ist aufgetreten. Bitte versuchen Sie es erneut.';

  @override
  String get errorsNetwork => 'Überprüfen Sie Ihre Internetverbindung.';

  @override
  String get errorsInvalidCredentials => 'Ungültige E-Mail oder Passwort';

  @override
  String get errorsUserNotFound => 'Benutzer nicht gefunden';

  @override
  String get errorsEmailAlreadyExists => 'E-Mail ist bereits registriert';

  @override
  String get errorsWeakPassword => 'Das Passwort ist zu schwach';

  @override
  String get successLoginSuccess => 'Anmeldung erfolgreich';

  @override
  String get successRegisterSuccess => 'Registrierung erfolgreich';

  @override
  String get successProfileUpdated => 'Profil erfolgreich aktualisiert';

  @override
  String get successPasswordResetSent =>
      'E-Mail zum Zurücksetzen des Passworts gesendet';

  @override
  String get buttonsSave => 'Speichern';

  @override
  String get buttonsCancel => 'Abbrechen';

  @override
  String get buttonsDelete => 'Löschen';

  @override
  String get buttonsEdit => 'Bearbeiten';

  @override
  String get buttonsUpdate => 'Aktualisieren';

  @override
  String get buttonsUpload => 'Hochladen';

  @override
  String get buttonsDownload => 'Herunterladen';

  @override
  String get buttonsRetry => 'Wiederholen';

  @override
  String get buttonsOk => 'OK';

  @override
  String get buttonsYes => 'Ja';

  @override
  String get buttonsNo => 'Nein';

  @override
  String greetingWithName(String name) {
    return 'Hallo, $name!';
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
      other: '$countString Elemente',
      one: 'Ein Element',
      zero: 'Keine Elemente',
    );
    return '$_temp0';
  }

  @override
  String lastSeen(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Zuletzt gesehen $dateString';
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
  String get languagesEn => 'Englisch';

  @override
  String get languagesTr => 'Türkisch';

  @override
  String get languagesEs => 'Spanisch';

  @override
  String get languagesFr => 'Französisch';

  @override
  String get languagesDe => 'Deutsch';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeSystem => 'System';
}
