import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/localization_provider.dart';
import '../../../core/services/localization_service.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../auth/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.home,
        actions: [
          // Language Selector
          const LanguageSelector(),
          const SizedBox(width: 8),
          // Profile button
          IconButton(icon: const Icon(Icons.person), onPressed: () => context.push('/profile')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${l10n.welcome} 👋', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Text(
                      l10n.greetingWithName(currentUser?.name ?? currentUser?.email ?? 'User'),
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Bu, Supabase entegreli Flutter temel projesidir. Buradan yeni özellikler eklemeye başlayabilirsiniz.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Language Test Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.language, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          'Dil Testi / Language Test',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTestSection(context, l10n),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Actions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hızlı İşlemler', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => context.push('/profile'),
                            icon: const Icon(Icons.person),
                            label: Text(l10n.profile),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => context.push('/settings'),
                            icon: const Icon(Icons.settings),
                            label: Text(l10n.settings),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Sign Out Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => ref.read(authProvider.notifier).signOut(),
                icon: const Icon(Icons.logout),
                label: Text(l10n.signOut),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestSection(BuildContext context, AppLocalizations l10n) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('• ${l10n.login} / ${l10n.register}'),
      Text('• ${l10n.email}: ${l10n.emailHint}'),
      Text('• ${l10n.password}: ${l10n.passwordHint}'),
      const SizedBox(height: 8),
      Text('• ${l10n.validationEmailRequired}'),
      Text('• ${l10n.validationPasswordTooShort}'),
      const SizedBox(height: 8),
      Text('• ${l10n.successLoginSuccess}'),
      Text('• ${l10n.errorsNetwork}'),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        children: [
          Chip(label: Text(l10n.buttonsSave)),
          Chip(label: Text(l10n.buttonsCancel)),
          Chip(label: Text(l10n.buttonsUpdate)),
        ],
      ),
    ],
  );
}

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localizationProvider);
    final localizationNotifier = ref.read(localizationProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          value: currentLocale,
          icon: const SizedBox.shrink(), // Hide default icon
          elevation: 0,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
          borderRadius: BorderRadius.circular(8),
          items: LocalizationService.supportedLocales
              .map(
                (locale) => DropdownMenuItem<Locale>(
                  value: locale,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        LocalizationService.instance.getLanguageFlag(locale.languageCode),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        locale.languageCode.toUpperCase(),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: (Locale? newLocale) {
            if (newLocale != null) {
              localizationNotifier.changeLanguage(newLocale);
            }
          },
        ),
      ),
    );
  }
}
