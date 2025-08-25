import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/widgets/auth_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profil',
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            // Profile Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: currentUser?.avatarUrl != null
                          ? ClipOval(
                              child: Image.network(
                                currentUser!.avatarUrl!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildDefaultAvatar(context, currentUser),
                              ),
                            )
                          : _buildDefaultAvatar(context, currentUser),
                    ),
                    const SizedBox(height: 16),

                    // Name
                    Text(
                      currentUser?.name ?? 'İsimsiz Kullanıcı',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Email
                    Text(
                      currentUser?.email ?? '',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Profile Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hesap Bilgileri', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),

                    _buildInfoRow(context, 'Kullanıcı ID', currentUser?.id ?? ''),
                    const Divider(),

                    _buildInfoRow(
                      context,
                      'Kayıt Tarihi',
                      currentUser?.createdAt.toString().split(' ')[0] ?? '',
                    ),
                    const Divider(),

                    _buildInfoRow(
                      context,
                      'Son Giriş',
                      currentUser?.lastSignInAt?.toString().split(' ')[0] ?? 'Bilgi yok',
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Logout Button
            AuthButton(
              text: 'Çıkış Yap',
              onPressed: () => _showLogoutDialog(context, ref),
              isLoading: authState.isLoading,
              backgroundColor: Colors.red,
              icon: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar(BuildContext context, user) {
    final initial = user?.name?.isNotEmpty == true
        ? user!.name![0].toUpperCase()
        : user?.email?.isNotEmpty == true
        ? user!.email![0].toUpperCase()
        : 'U';

    return Text(
      initial.toString(),
      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyMedium)),
      ],
    ),
  );

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text('Hesabınızdan çıkış yapmak istediğinizden emin misiniz?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('İptal')),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(authProvider.notifier).signOut();
            },
            child: const Text('Çıkış Yap'),
          ),
        ],
      ),
    );
  }
}
