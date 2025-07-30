import 'package:equatable/equatable.dart';
import 'package:ledger/core/common/user_related_entities/budget.dart';
import 'package:ledger/core/common/user_related_entities/business_info.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthEventCheckRequested extends AuthEvent {
  const AuthEventCheckRequested();
}

final class AuthEventLoginRequested extends AuthEvent {
  const AuthEventLoginRequested({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

final class AuthEventRegisterRequested extends AuthEvent {
  const AuthEventRegisterRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.accountType,
    required this.budget,
    this.businessInfo,
  });

  final String email;
  final String password;
  final String name;
  final String phone;
  final String accountType;
  final BudgetEntity budget;
  final BusinessInfoEntity? businessInfo;

  @override
  List<Object> get props => [email, password, name, phone, accountType, budget];
}

final class AuthEventForgotPasswordRequested extends AuthEvent {
  const AuthEventForgotPasswordRequested({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

final class AuthEventVerifyOtpRequested extends AuthEvent {
  const AuthEventVerifyOtpRequested({required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  List<Object?> get props => [email, otp];
}

final class AuthEventVerifyTokenRequested extends AuthEvent {
  const AuthEventVerifyTokenRequested(this.token);

  final String token;

  @override
  List<Object?> get props => [token];
}

final class AuthEventVerifyEmailRequested extends AuthEvent {
  const AuthEventVerifyEmailRequested({required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  List<Object?> get props => [email, otp];
}

final class AuthEventResetPasswordRequested extends AuthEvent {
  const AuthEventResetPasswordRequested({
    required this.resetToken,
    required this.newPassword,
  });

  final String resetToken;
  final String newPassword;

  @override
  List<Object?> get props => [resetToken, newPassword];
}

final class AuthEventLogoutRequested extends AuthEvent {
  const AuthEventLogoutRequested(this.email);
  final String email;

  @override
  List<Object?> get props => [email];
}

final class AuthEventTokenRefreshRequested extends AuthEvent {
  const AuthEventTokenRefreshRequested(this.currentToken);

  final String currentToken;

  @override
  List<Object?> get props => [currentToken];
}

final class AuthEventBiometricLoginRequested extends AuthEvent {
  const AuthEventBiometricLoginRequested();
}

final class AuthEventBiometricLoginEnable extends AuthEvent {
  const AuthEventBiometricLoginEnable();
}

final class AuthEventBiometricLoginDisabled extends AuthEvent {
  const AuthEventBiometricLoginDisabled();
}
