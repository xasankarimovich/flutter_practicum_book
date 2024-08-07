import 'package:buksam_flutter_practicum/data/models/forum_status/form_status.dart';
import 'package:firebase_auth/firebase_auth.dart';

// enum AuthStatus { initial, loading, authenticated, error, loggedOut }

class AuthState {
  final ForumStatus status;
  final User? user;
  final String errorMessage;

  const AuthState({
    required this.status,
    required this.user,
    required this.errorMessage,
  });

  AuthState copyWith({
    String? errorMessage,
    ForumStatus? status,
    User? user,
  }) =>
      AuthState(
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        user: user ?? this.user,
      );

  static AuthState initialValue() => const AuthState(
        errorMessage: '',
        status: ForumStatus.initial,
        user: null,
      );
}
