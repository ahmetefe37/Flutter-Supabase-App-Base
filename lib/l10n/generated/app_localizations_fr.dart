// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Supa Sample';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get login => 'Se Connecter';

  @override
  String get register => 'S\'inscrire';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de Passe';

  @override
  String get confirmPassword => 'Confirmer le Mot de Passe';

  @override
  String get name => 'Nom';

  @override
  String get forgotPassword => 'Mot de Passe Oublié';

  @override
  String get resetPassword => 'Réinitialiser le Mot de Passe';

  @override
  String get signOut => 'Se Déconnecter';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Paramètres';

  @override
  String get home => 'Accueil';

  @override
  String get emailHint => 'Entrez votre e-mail';

  @override
  String get passwordHint => 'Entrez votre mot de passe';

  @override
  String get nameHint => 'Entrez votre nom';

  @override
  String get loginTitle => 'Bon Retour';

  @override
  String get loginSubtitle => 'Connectez-vous à votre compte';

  @override
  String get registerTitle => 'Créer un Compte';

  @override
  String get registerSubtitle => 'Créez un nouveau compte';

  @override
  String get validationEmailRequired => 'L\'e-mail est requis';

  @override
  String get validationEmailInvalid => 'Entrez une adresse e-mail valide';

  @override
  String get validationPasswordRequired => 'Le mot de passe est requis';

  @override
  String get validationPasswordTooShort =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get validationPasswordMismatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get validationNameRequired => 'Le nom est requis';

  @override
  String get errorsGeneral => 'Une erreur s\'est produite. Veuillez réessayer.';

  @override
  String get errorsNetwork => 'Vérifiez votre connexion internet.';

  @override
  String get errorsInvalidCredentials => 'E-mail ou mot de passe invalide';

  @override
  String get errorsUserNotFound => 'Utilisateur non trouvé';

  @override
  String get errorsEmailAlreadyExists => 'L\'e-mail est déjà enregistré';

  @override
  String get errorsWeakPassword => 'Le mot de passe est trop faible';

  @override
  String get successLoginSuccess => 'Connexion réussie';

  @override
  String get successRegisterSuccess => 'Inscription réussie';

  @override
  String get successProfileUpdated => 'Profil mis à jour avec succès';

  @override
  String get successPasswordResetSent =>
      'E-mail de réinitialisation du mot de passe envoyé';

  @override
  String get buttonsSave => 'Enregistrer';

  @override
  String get buttonsCancel => 'Annuler';

  @override
  String get buttonsDelete => 'Supprimer';

  @override
  String get buttonsEdit => 'Modifier';

  @override
  String get buttonsUpdate => 'Mettre à Jour';

  @override
  String get buttonsUpload => 'Télécharger';

  @override
  String get buttonsDownload => 'Télécharger';

  @override
  String get buttonsRetry => 'Réessayer';

  @override
  String get buttonsOk => 'OK';

  @override
  String get buttonsYes => 'Oui';

  @override
  String get buttonsNo => 'Non';

  @override
  String greetingWithName(String name) {
    return 'Bonjour, $name!';
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
      other: '$countString éléments',
      one: 'Un élément',
      zero: 'Aucun élément',
    );
    return '$_temp0';
  }

  @override
  String lastSeen(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Vu pour la dernière fois $dateString';
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
  String get languagesEn => 'Anglais';

  @override
  String get languagesTr => 'Turc';

  @override
  String get languagesEs => 'Espagnol';

  @override
  String get languagesFr => 'Français';

  @override
  String get languagesDe => 'Allemand';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeSystem => 'Système';
}
