import 'package:ledger/core/services/use_cases.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/domain/repos/auth_repos.dart';

class ForgotPasswordUseCase extends UseCaseWithParams<void, String> {
  const ForgotPasswordUseCase(this._repos);

  final AuthRepos _repos;
  @override
  ResultFuture<void> call(String params) =>
      _repos.forgotPassword(email: params);
}
