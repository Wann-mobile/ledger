import 'package:equatable/equatable.dart';
import 'package:ledger/core/common/user_related_entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthStateInitial extends AuthState {
  const AuthStateInitial();
}

final class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

final class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated(this.user, this.token);

  final UserEntity user;
  final String token;

  @override
  List<Object?> get props => [user, token];
}

final class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut();
}

final class AuthStateRegistration extends AuthState {
  const AuthStateRegistration(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

final class AuthStateForgotPassword extends AuthState {
  const AuthStateForgotPassword();
}

final class AuthStateOtpVerifed extends AuthState {
  const AuthStateOtpVerifed(this.resetToken);

  final String resetToken;

  @override
  List<Object?> get props => [resetToken];
}

final class AuthStatePasswordReset extends AuthState {
  const AuthStatePasswordReset();
}

final class AuthStateTokenRefreshed extends AuthState {
  const AuthStateTokenRefreshed(this.currentToken);

  final String currentToken;

  @override
  List<Object?> get props => [currentToken];
}

final class AuthStateBiometricRequired extends AuthState {
  const AuthStateBiometricRequired();
}

final class AuthStateOnboardingRequired extends AuthState {
  const AuthStateOnboardingRequired();
}

final class AuthStateEmailVerification extends AuthState {
  const AuthStateEmailVerification(this.isEmailVerified);

  final bool isEmailVerified;

  @override
  List<Object?> get props => [isEmailVerified];
}

final class AuthStateError extends AuthState {
  final String message;
  final int statusCode;

  const AuthStateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
