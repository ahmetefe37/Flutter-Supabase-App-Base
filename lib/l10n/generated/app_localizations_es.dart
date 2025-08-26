// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Supa Sample';

  @override
  String get welcome => 'Bienvenido';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get register => 'Registrarse';

  @override
  String get email => 'Correo Electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get confirmPassword => 'Confirmar Contraseña';

  @override
  String get name => 'Nombre';

  @override
  String get forgotPassword => 'Olvidé mi Contraseña';

  @override
  String get resetPassword => 'Restablecer Contraseña';

  @override
  String get signOut => 'Cerrar Sesión';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Configuración';

  @override
  String get home => 'Inicio';

  @override
  String get emailHint => 'Ingrese su correo electrónico';

  @override
  String get passwordHint => 'Ingrese su contraseña';

  @override
  String get nameHint => 'Ingrese su nombre';

  @override
  String get loginTitle => 'Bienvenido de Nuevo';

  @override
  String get loginSubtitle => 'Inicie sesión en su cuenta';

  @override
  String get registerTitle => 'Crear Cuenta';

  @override
  String get registerSubtitle => 'Cree una nueva cuenta';

  @override
  String get validationEmailRequired => 'El correo electrónico es requerido';

  @override
  String get validationEmailInvalid => 'Ingrese un correo electrónico válido';

  @override
  String get validationPasswordRequired => 'La contraseña es requerida';

  @override
  String get validationPasswordTooShort =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get validationPasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String get validationNameRequired => 'El nombre es requerido';

  @override
  String get errorsGeneral =>
      'Ocurrió un error. Por favor, inténtelo de nuevo.';

  @override
  String get errorsNetwork => 'Verifique su conexión a internet.';

  @override
  String get errorsInvalidCredentials =>
      'Correo electrónico o contraseña inválidos';

  @override
  String get errorsUserNotFound => 'Usuario no encontrado';

  @override
  String get errorsEmailAlreadyExists =>
      'El correo electrónico ya está registrado';

  @override
  String get errorsWeakPassword => 'La contraseña es muy débil';

  @override
  String get successLoginSuccess => 'Inicio de sesión exitoso';

  @override
  String get successRegisterSuccess => 'Registro exitoso';

  @override
  String get successProfileUpdated => 'Perfil actualizado exitosamente';

  @override
  String get successPasswordResetSent =>
      'Correo de restablecimiento de contraseña enviado';

  @override
  String get buttonsSave => 'Guardar';

  @override
  String get buttonsCancel => 'Cancelar';

  @override
  String get buttonsDelete => 'Eliminar';

  @override
  String get buttonsEdit => 'Editar';

  @override
  String get buttonsUpdate => 'Actualizar';

  @override
  String get buttonsUpload => 'Subir';

  @override
  String get buttonsDownload => 'Descargar';

  @override
  String get buttonsRetry => 'Reintentar';

  @override
  String get buttonsOk => 'Aceptar';

  @override
  String get buttonsYes => 'Sí';

  @override
  String get buttonsNo => 'No';

  @override
  String greetingWithName(String name) {
    return '¡Hola, $name!';
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
      other: '$countString elementos',
      one: 'Un elemento',
      zero: 'Sin elementos',
    );
    return '$_temp0';
  }

  @override
  String lastSeen(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Visto por última vez $dateString';
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
  String get languagesEn => 'Inglés';

  @override
  String get languagesTr => 'Turco';

  @override
  String get languagesEs => 'Español';

  @override
  String get languagesFr => 'Francés';

  @override
  String get languagesDe => 'Alemán';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';
}
