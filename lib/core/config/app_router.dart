import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../constants/route_constants.dart';
import 'splash_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter(ProviderRef<GoRouter> ref) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: RouteConstants.splash,
      debugLogDiagnostics: true,

      // Redirect logic
      redirect: (context, state) {
        final authState = ref.read(authProvider);
        final isAuthenticated = authState.isAuthenticated;
        final isLoading = authState.isLoading;

        // Skip redirect if still loading
        if (isLoading) return null;

        final isGoingToAuth =
            state.matchedLocation == RouteConstants.login ||
            state.matchedLocation == RouteConstants.register ||
            state.matchedLocation == RouteConstants.forgotPassword;

        final isGoingToSplash = state.matchedLocation == RouteConstants.splash;

        // If not authenticated and not going to auth screens, redirect to login
        if (!isAuthenticated && !isGoingToAuth && !isGoingToSplash) {
          return RouteConstants.login;
        }

        // If authenticated and going to auth screens, redirect to home
        if (isAuthenticated && (isGoingToAuth || isGoingToSplash)) {
          return RouteConstants.home;
        }

        return null;
      },

      routes: [
        // Splash Screen
        GoRoute(
          path: RouteConstants.splash,
          name: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),

        // Auth Routes
        GoRoute(
          path: RouteConstants.login,
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),

        GoRoute(
          path: RouteConstants.register,
          name: 'register',
          builder: (context, state) => const RegisterScreen(),
        ),

        GoRoute(
          path: RouteConstants.forgotPassword,
          name: 'forgot-password',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),

        // Protected Routes
        GoRoute(
          path: RouteConstants.home,
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),

        GoRoute(
          path: RouteConstants.profile,
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],

      // Error handling
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64),
              const SizedBox(height: 16),
              Text(
                'Sayfa Bulunamadı',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text('${state.uri} sayfası mevcut değil'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go(RouteConstants.home),
                child: const Text('Ana Sayfaya Dön'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Router Provider
final routerProvider = Provider<GoRouter>((ref) {
  return AppRouter.createRouter(ref);
});
