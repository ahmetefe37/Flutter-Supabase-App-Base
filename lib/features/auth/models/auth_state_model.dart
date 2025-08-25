import 'user_model.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthStateModel {
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;
  final bool isLoading;

  const AuthStateModel({
    required this.status,
    this.user,
    this.errorMessage,
    this.isLoading = false,
  });

  // Initial state
  factory AuthStateModel.initial() {
    return const AuthStateModel(status: AuthStatus.initial, isLoading: false);
  }

  // Loading state
  factory AuthStateModel.loading() {
    return const AuthStateModel(status: AuthStatus.loading, isLoading: true);
  }

  // Authenticated state
  factory AuthStateModel.authenticated(UserModel user) {
    return AuthStateModel(
      status: AuthStatus.authenticated,
      user: user,
      isLoading: false,
    );
  }

  // Unauthenticated state
  factory AuthStateModel.unauthenticated() {
    return const AuthStateModel(
      status: AuthStatus.unauthenticated,
      isLoading: false,
    );
  }

  // Error state
  factory AuthStateModel.error(String message) {
    return AuthStateModel(
      status: AuthStatus.error,
      errorMessage: message,
      isLoading: false,
    );
  }

  // Copy with
  AuthStateModel copyWith({
    AuthStatus? status,
    UserModel? user,
    String? errorMessage,
    bool? isLoading,
  }) {
    return AuthStateModel(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  // Getters
  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  bool get hasError => status == AuthStatus.error;
  bool get isInitial => status == AuthStatus.initial;
}
