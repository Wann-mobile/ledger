import 'package:bloc/bloc.dart';
import 'package:ledger/src/auth/domain/use_case/biometric_disabled_use_case.dart';
import 'package:ledger/src/auth/domain/use_case/biometric_enabled_use_case.dart';
import 'package:ledger/src/auth/domain/use_case/biometric_login_use_case.dart';
import 'package:ledger/src/auth/domain/use_case/forgot_password_use_case.dart';
import 'package:ledger/src/auth/domain/use_case/login_use_case.dart';
import 'package:ledger/src/auth/domain/use_case/logout_use_case.dart';
import 'package:ledger/src/auth/domain/use_case/refresh_token_use_case.dart';
import 'package:ledger/src/auth/domain/use_case/register_use_case.dart';
import 'package:ledger/src/auth/domain/use_case/reset_password_use_case.dart';
import 'package:ledger/src/auth/domain/use_case/verify_email_use_case.dart';
import 'package:ledger/src/auth/domain/use_case/verify_otp_use_case.dart';
import 'package:ledger/src/auth/presentation/adapter/auth_event.dart';
import 'package:ledger/src/auth/presentation/adapter/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required ForgotPasswordUseCase forgotPassword,
    required LoginUseCase login,
    required LogoutUseCase logout,
    required RefreshTokenUseCase refreshToken,
    required RegisterUseCase register,
    required ResetPasswordUseCase resetpassword,
    required VerifyEmailUseCase verifyEmail,
    required VerifyOtpUseCase verifyOtp,
    required BiometricLoginUseCase biometricLoginUseCase,
    required BiometricEnabledUseCase biometricEnabledUseCase,
    required BiometricDisabledUseCase biometricDisabledUseCase,
  }) : _forgotPassword = forgotPassword,
       _login = login,
       _logout = logout,
       _refreshToken = refreshToken,
       _register = register,
       _resetpassword = resetpassword,
       _verifyEmail = verifyEmail,
       _verifyOtp = verifyOtp,
       _biometricLoginUseCase = biometricLoginUseCase,
       _biometricEnabledUseCase = biometricEnabledUseCase,
       _biometricDisabledUseCase = biometricDisabledUseCase,

       super(const AuthStateInitial()) {
    on<AuthEventLoginRequested>(_onLoginRequested);
    on<AuthEventRegisterRequested>(_onRegisterRequested);
    on<AuthEventForgotPasswordRequested>(_onForgotPasswordRequested);
    on<AuthEventResetPasswordRequested>(_onResetPasswordRequested);
    on<AuthEventVerifyOtpRequested>(_onVerifyOtpRequested);
    // on<AuthEventVerifyTokenRequested>(_onVerifyTokenRequested);
    on<AuthEventVerifyEmailRequested>(_onVerifyEmailRequested);
    on<AuthEventBiometricLoginRequested>(_onBiometricLoginRequested);
    on<AuthEventLogoutRequested>(_onLogoutRequested);
    on<AuthEventTokenRefreshRequested>(_onTokenRefreshRequested);
    on<AuthEventBiometricLoginEnable>(_onBiometricLoginEnable);
    on<AuthEventBiometricLoginDisabled>(_onBiometricLoginDisabled);
  }

  final ForgotPasswordUseCase _forgotPassword;
  final LoginUseCase _login;
  final LogoutUseCase _logout;
  final RefreshTokenUseCase _refreshToken;
  final RegisterUseCase _register;
  final ResetPasswordUseCase _resetpassword;
  final VerifyEmailUseCase _verifyEmail;
  final VerifyOtpUseCase _verifyOtp;
  final BiometricLoginUseCase _biometricLoginUseCase;
  final BiometricEnabledUseCase _biometricEnabledUseCase;
  final BiometricDisabledUseCase _biometricDisabledUseCase;

  Future<void> _onForgotPasswordRequested(
    AuthEventForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    final result = await _forgotPassword(event.email);
    result.fold(
      (failure) => emit(AuthStateError(failure.message, failure.statusCode)),
      (_) => emit(AuthStateForgotPassword()),
    );
  }

  Future<void> _onLoginRequested(
    AuthEventLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    final result = await _login(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthStateError(failure.message, failure.statusCode)),
      (loginResponse) async {
        emit(
          AuthStateAuthenticated(
            loginResponse.response['user'],
            loginResponse.response['token'],
          ),
        );
      },
    );
  }

  Future<void> _onRegisterRequested(
    AuthEventRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    final result = await _register(
      RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
        phone: event.phone,
        accountType: event.accountType,
        budget: event.budget,
        businessInfo: event.businessInfo,
      ),
    );
    result.fold(
      (failure) => emit(AuthStateError(failure.message, failure.statusCode)),
      (response) {
        emit(AuthStateRegistration(event.email));
      },
    );
  }

  Future<void> _onResetPasswordRequested(
    AuthEventResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    final result = await _resetpassword(
      ResetPasswordUseCaseParams(
        resetToken: event.resetToken,
        newPassword: event.newPassword,
      ),
    );
    result.fold(
      (failure) => emit(AuthStateError(failure.message, failure.statusCode)),
      (_) => emit(AuthStatePasswordReset()),
    );
  }

  Future<void> _onVerifyEmailRequested(
    AuthEventVerifyEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    final result = await _verifyEmail(
      VerifyEmailUseCaseParams(email: event.email, otp: event.otp),
    );
    result.fold(
      (failure) => emit(AuthStateError(failure.message, failure.statusCode)),
      (verifyEmailresponse) => emit(
        AuthStateAuthenticated(
          verifyEmailresponse.response['user'],
          verifyEmailresponse.response['token'],
        ),
      ),
    );
  }

  Future<void> _onLogoutRequested(
    AuthEventLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    final result = await _logout(event.email);
    result.fold(
      (failure) => emit(AuthStateError(failure.message, failure.statusCode)),
      (_) => emit(AuthStateLoggedOut()),
    );
  }

  Future<void> _onVerifyOtpRequested(
    AuthEventVerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    final result = await _verifyOtp(
      VerifyOtpUseCaseParams(email: event.email, otp: event.otp),
    );
    result.fold(
      (failure) => emit(AuthStateError(failure.message, failure.statusCode)),
      (resetToken) => emit(AuthStateOtpVerifed(resetToken)),
    );
  }

  Future<void> _onTokenRefreshRequested(
    AuthEventTokenRefreshRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    final result = await _refreshToken(event.currentToken);
    result.fold(
      (failure) => emit(AuthStateError(failure.message, failure.statusCode)),
      (_) => emit(AuthStateTokenRefreshed(event.currentToken)),
    );
  }

  Future<void> _onBiometricLoginRequested(
    AuthEventBiometricLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    final result = await _biometricLoginUseCase();
    result.fold(
      (failure) => emit(AuthStateError(failure.message, failure.statusCode)),
      (authResponse) => emit(
        AuthStateAuthenticated(
          authResponse.response['user'],
          authResponse.response['token'],
        ),
      ),
    );
  }

  Future<void> _onBiometricLoginEnable(
    AuthEventBiometricLoginEnable event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final success = await _biometricEnabledUseCase();
      if (success) {
        emit(AuthStateBiometricRequired());
      } else {
        emit(AuthStateError('Failed to enable biometric login', 400));
      }
    } catch (e) {
      emit(AuthStateError(e.toString(), 401));
    }
  }

  Future<void> _onBiometricLoginDisabled(
    AuthEventBiometricLoginDisabled event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _biometricDisabledUseCase();
    } catch (e) {
      emit(AuthStateError(e.toString(), 401));
    }
  }
}
