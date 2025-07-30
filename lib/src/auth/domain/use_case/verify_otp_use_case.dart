import 'package:equatable/equatable.dart';
import 'package:ledger/core/services/use_cases.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/domain/repos/auth_repos.dart';

class VerifyOtpUseCase
    extends UseCaseWithParams<String, VerifyOtpUseCaseParams> {
  const VerifyOtpUseCase(this._repos);
  final AuthRepos _repos;
  @override
  ResultFuture<String> call(VerifyOtpUseCaseParams params) =>
      _repos.verifyOtp(email: params.email, otp: params.otp);
}

class VerifyOtpUseCaseParams extends Equatable {
  const VerifyOtpUseCaseParams({required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  List<Object?> get props => [email, otp];
}
