import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:ledger/core/common/app/service_storage.dart';
import 'package:ledger/core/common/providers/session_provider.dart';
import 'package:ledger/core/common/user_related_entities/budget.dart';
import 'package:ledger/core/common/user_related_entities/business_info.dart';
import 'package:ledger/core/errors/auth_exceptions.dart';
import 'package:ledger/core/errors/exceptions.dart';
import 'package:ledger/core/errors/failures.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/data/data_src/api_service.dart';
import 'package:ledger/src/auth/domain/entities/auth_response.dart';
import 'package:ledger/src/auth/domain/repos/auth_repos.dart';
import 'package:local_auth/local_auth.dart';

class AuthService implements AuthRepos {
  AuthService(this._apiService, this._storageService, this._sessionProvider);

  final ApiService _apiService;
  final SessionProvider _sessionProvider;
  final StorageService _storageService;
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  // Enhanced biometric authentication with preference saving
  Future<bool> authenticateWithBiometrics() async {
    try {
      final bool isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) {
        throw AuthException(message: 'Biometric authentication not available');
      }

      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access your account',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      return didAuthenticate;
    } on PlatformException catch (e) {
      throw AuthException(
        message: 'Biometric authentication failed: ${e.message}',
      );
    }
  }

  Future<bool> enableBiometricLogin() async {
    try {
      final bool isAuthenticated = await authenticateWithBiometrics();

      if (isAuthenticated) {
        // Save the preference
        await _sessionProvider.setBiometricPreference(true);
        return true;
      }

      return false;
    } catch (e) {
      throw AuthException(message: 'Failed to enable biometric login: $e');
    }
  }

  Future<void> disableBiometricLogin() async {
    try {
      await _sessionProvider.setBiometricPreference(false);
    } catch (e) {
      throw AuthException(message: 'Failed to disable biometric login: $e');
    }
  }

  ResultFuture<AuthResponse> loginWithBiometrics() async {
    try {
      // Check if biometric login is enabled
      if (!_sessionProvider.isBiometricEnabled) {
        throw AuthException(message: 'Biometric login is not enabled');
      }

      // Authenticate user biometrically
      final didAuthenticate = await authenticateWithBiometrics();
      if (!didAuthenticate) {
        return Left(
          (ServerFailure(message: 'Biometrics login Failed', statusCode: 500)),
        );
      }

      // Retrieve saved credentials
      final email = await _storageService.getStoredEmail();
      final password = await _storageService.getStoredPassword();

      if (email == null || password == null) {
        return Left(
          (ServerFailure(
            message: 'Credentials not available',
            statusCode: 404,
          )),
        );
      }

      final results = await _apiService.login(email: email, password: password);
      _apiService.setAuthToken(results.response['token']);
      await _sessionProvider.setSession(
        results.response['token'],
        results.response['user'],
      );
      return Right(results);
    } on ServerException catch (e) {
      _apiService.clearAuthToken();
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> forgotPassword({required String email}) async {
    try {
      await _apiService.forgotPassword(email: email);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final results = await _apiService.login(email: email, password: password);
      _apiService.setAuthToken(results.response['token']);
      await _sessionProvider.setSession(
        results.response['token'],
        results.response['user'],
      );
      return Right(results);
    } on ServerException catch (e) {
      _apiService.clearAuthToken();
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> logout({required String token}) async {
    try {
      await _apiService.logout(token: token);
      _apiService.setAuthToken(token);
      return Right(null);
    } finally {
      _apiService.clearAuthToken();
      await _sessionProvider.clearSession();
    }
  }

  @override
  ResultFuture<String> refreshToken({required String currentToken}) async {
    try {
      _apiService.setAuthToken(currentToken);
      final newToken = await _apiService.refreshToken(
        currentToken: currentToken,
      );
      _apiService.setAuthToken(newToken);
      if (_sessionProvider.user != null) {
        await _sessionProvider.setSession(newToken, _sessionProvider.user!);
      }
      return Right(newToken);
    } on ServerException catch (e) {
      _apiService.clearAuthToken();
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String accountType,
    required BudgetEntity budget,
    BusinessInfoEntity? businessInfo,
  }) async {
    try {
      final results = await _apiService.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        accountType: accountType,
        budget: budget,
      );
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> resetpassword({
    required String resetToken,
    required String newPassword,
  }) async {
    try {
      await _apiService.resetpassword(
        resetToken: resetToken,
        newPassword: newPassword,
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<AuthResponse> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      final results = await _apiService.verifyEmail(email: email, otp: otp);
      _apiService.setAuthToken(results.response['token']);
      await _sessionProvider.setSession(
        results.response['token'],
        results.response['user'],
      );
      return Right(results);
    } on ServerException catch (e) {
      _apiService.clearAuthToken();
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final results = await _apiService.verifyOtp(email: email, otp: otp);
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
