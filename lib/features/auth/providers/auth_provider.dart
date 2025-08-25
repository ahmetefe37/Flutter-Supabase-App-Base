import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/services/storage_service.dart';
import '../models/auth_state_model.dart';
import '../models/user_model.dart';

class AuthNotifier extends StateNotifier<AuthStateModel> {
  AuthNotifier() : super(AuthStateModel.initial()) {
    _init();
  }

  final _supabaseService = SupabaseService.instance;
  final _storageService = StorageService.instance;

  void _init() {
    // Listen to auth state changes
    _supabaseService.authStateChanges.listen((authState) {
      if (authState.session != null) {
        final user = UserModel.fromSupabaseUser(authState.session!.user);
        _saveUserData(user);
        state = AuthStateModel.authenticated(user);
      } else {
        _clearUserData();
        state = AuthStateModel.unauthenticated();
      }
    });

    // Check if user is already logged in
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final currentUser = _supabaseService.currentUser;
      if (currentUser != null) {
        final user = UserModel.fromSupabaseUser(currentUser);
        state = AuthStateModel.authenticated(user);
      } else {
        state = AuthStateModel.unauthenticated();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Auth status check error: $e');
      }
      state = AuthStateModel.unauthenticated();
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    state = AuthStateModel.loading();

    try {
      Map<String, dynamic>? userData;
      if (name != null) {
        userData = {'name': name};
      }

      final response = await _supabaseService.signUp(
        email: email,
        password: password,
        data: userData,
      );

      if (response.user != null) {
        final user = UserModel.fromSupabaseUser(response.user!);
        _saveUserData(user);
        state = AuthStateModel.authenticated(user);
      } else {
        state = AuthStateModel.error('Registration failed!');
      }
    } catch (e) {
      state = AuthStateModel.error(_getErrorMessage(e));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    state = AuthStateModel.loading();

    try {
      final response = await _supabaseService.signIn(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final user = UserModel.fromSupabaseUser(response.user!);
        _saveUserData(user);
        state = AuthStateModel.authenticated(user);
      } else {
        state = AuthStateModel.error('Login failed');
      }
    } catch (e) {
      state = AuthStateModel.error(_getErrorMessage(e));
    }
  }

  Future<void> signOut() async {
    state = AuthStateModel.loading();

    try {
      await _supabaseService.signOut();
      _clearUserData();
      state = AuthStateModel.unauthenticated();
    } catch (e) {
      state = AuthStateModel.error(_getErrorMessage(e));
    }
  }

  Future<void> resetPassword(String email) async {
    state = AuthStateModel.loading();

    try {
      await _supabaseService.resetPassword(email);
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
      );
    } catch (e) {
      state = AuthStateModel.error(_getErrorMessage(e));
    }
  }

  void clearError() {
    if (state.hasError) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: null,
      );
    }
  }

  Future<void> _saveUserData(UserModel user) async {
    await _storageService.saveUserData(user.toJson());
  }

  Future<void> _clearUserData() async {
    await _storageService.clearUserData();
  }

  String _getErrorMessage(dynamic error) {
    if (error is AuthException) {
      switch (error.message) {
        case 'Invalid login credentials':
          return 'Invalid email or password';
        case 'Email not confirmed':
          return 'Please confirm your email address';
        case 'User already registered':
          return 'This email address is already registered';
        case 'Password should be at least 6 characters':
          return 'Password must be at least 6 characters long';
        default:
          return error.message;
      }
    }
    return 'An unexpected error occurred';
  }
}

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthStateModel>((ref) {
  return AuthNotifier();
});

// Current user provider
final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.user;
});

// Auth status provider
final authStatusProvider = Provider<AuthStatus>((ref) {
  final authState = ref.watch(authProvider);
  return authState.status;
});
