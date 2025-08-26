// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Supa Sample';

  @override
  String get welcome => 'Hoş Geldiniz';

  @override
  String get login => 'Giriş Yap';

  @override
  String get register => 'Kayıt Ol';

  @override
  String get email => 'E-posta';

  @override
  String get password => 'Şifre';

  @override
  String get confirmPassword => 'Şifre Tekrar';

  @override
  String get name => 'İsim';

  @override
  String get forgotPassword => 'Şifremi Unuttum';

  @override
  String get resetPassword => 'Şifre Sıfırla';

  @override
  String get signOut => 'Çıkış Yap';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Ayarlar';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get emailHint => 'E-posta adresinizi girin';

  @override
  String get passwordHint => 'Şifrenizi girin';

  @override
  String get nameHint => 'İsminizi girin';

  @override
  String get loginTitle => 'Hoş Geldiniz';

  @override
  String get loginSubtitle => 'Hesabınıza giriş yapın';

  @override
  String get registerTitle => 'Hesap Oluşturun';

  @override
  String get registerSubtitle => 'Yeni bir hesap oluşturun';

  @override
  String get validationEmailRequired => 'E-posta adresi gereklidir';

  @override
  String get validationEmailInvalid => 'Geçerli bir e-posta adresi girin';

  @override
  String get validationPasswordRequired => 'Şifre gereklidir';

  @override
  String get validationPasswordTooShort => 'Şifre en az 6 karakter olmalıdır';

  @override
  String get validationPasswordMismatch => 'Şifreler eşleşmiyor';

  @override
  String get validationNameRequired => 'İsim gereklidir';

  @override
  String get errorsGeneral => 'Bir hata oluştu. Lütfen tekrar deneyin.';

  @override
  String get errorsNetwork => 'İnternet bağlantınızı kontrol edin.';

  @override
  String get errorsInvalidCredentials => 'Geçersiz e-posta veya şifre';

  @override
  String get errorsUserNotFound => 'Kullanıcı bulunamadı';

  @override
  String get errorsEmailAlreadyExists => 'E-posta adresi zaten kayıtlı';

  @override
  String get errorsWeakPassword => 'Şifre çok zayıf';

  @override
  String get successLoginSuccess => 'Giriş başarılı';

  @override
  String get successRegisterSuccess => 'Kayıt başarılı';

  @override
  String get successProfileUpdated => 'Profil başarıyla güncellendi';

  @override
  String get successPasswordResetSent => 'Şifre sıfırlama e-postası gönderildi';

  @override
  String get buttonsSave => 'Kaydet';

  @override
  String get buttonsCancel => 'İptal';

  @override
  String get buttonsDelete => 'Sil';

  @override
  String get buttonsEdit => 'Düzenle';

  @override
  String get buttonsUpdate => 'Güncelle';

  @override
  String get buttonsUpload => 'Yükle';

  @override
  String get buttonsDownload => 'İndir';

  @override
  String get buttonsRetry => 'Tekrar Dene';

  @override
  String get buttonsOk => 'Tamam';

  @override
  String get buttonsYes => 'Evet';

  @override
  String get buttonsNo => 'Hayır';

  @override
  String greetingWithName(String name) {
    return 'Merhaba, $name!';
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
      other: '$countString öğe',
      one: 'Bir öğe',
      zero: 'Öğe yok',
    );
    return '$_temp0';
  }

  @override
  String lastSeen(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Son görülme $dateString';
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
  String get languagesEn => 'İngilizce';

  @override
  String get languagesTr => 'Türkçe';

  @override
  String get languagesEs => 'İspanyolca';

  @override
  String get languagesFr => 'Fransızca';

  @override
  String get languagesDe => 'Almanca';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get themeSystem => 'Sistem';
}
