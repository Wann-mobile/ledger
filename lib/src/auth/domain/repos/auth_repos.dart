import 'package:ledger/core/common/user_related_entities/budget.dart';
import 'package:ledger/core/common/user_related_entities/business_info.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/domain/entities/auth_response.dart';

abstract class AuthRepos {
  const AuthRepos();

  ResultFuture<AuthResponse> login({
    required String email,
    required String password,
  });

  ResultFuture<String> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String accountType,
    required BudgetEntity budget,
    BusinessInfoEntity? businessInfo,
  });

  ResultFuture<AuthResponse> verifyEmail({
    required String email,
    required String otp,
  });

  ResultFuture<void> logout({required String token});

  ResultFuture<String> refreshToken({required String currentToken});

  ResultFuture<void> forgotPassword({required String email});

  ResultFuture<String> verifyOtp({required String email, required String otp});

  ResultFuture<void> resetpassword({
    required String resetToken,
    required String newPassword,
  });
}
