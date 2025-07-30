import 'package:equatable/equatable.dart';
import 'package:ledger/core/services/use_cases.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/domain/repos/auth_repos.dart';

class ResetPasswordUseCase
    extends UseCaseWithParams<void, ResetPasswordUseCaseParams> {
  const ResetPasswordUseCase(this._repos);
  final AuthRepos _repos;
  @override
  ResultFuture<void> call(ResetPasswordUseCaseParams params) =>
      _repos.resetpassword(
        resetToken: params.resetToken,
        newPassword: params.newPassword,
      );
}

class ResetPasswordUseCaseParams extends Equatable {
  const ResetPasswordUseCaseParams({
    required this.resetToken,
    required this.newPassword,
  });

  final String resetToken;
  final String newPassword;

  @override
  List<Object?> get props => [resetToken, newPassword];
}
