import 'package:equatable/equatable.dart';
import 'package:ledger/core/services/use_cases.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/domain/entities/auth_response.dart';
import 'package:ledger/src/auth/domain/repos/auth_repos.dart';

class VerifyEmailUseCase
    extends UseCaseWithParams<AuthResponse, VerifyEmailUseCaseParams> {
  const VerifyEmailUseCase(this._repos);
  final AuthRepos _repos;
  @override
  ResultFuture<AuthResponse> call(VerifyEmailUseCaseParams params) =>
      _repos.verifyEmail(email: params.email, otp: params.otp);
}

class VerifyEmailUseCaseParams extends Equatable {
  const VerifyEmailUseCaseParams({required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  List<Object?> get props => [email, otp];
}
