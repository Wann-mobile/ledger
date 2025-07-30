import 'package:ledger/core/services/use_cases.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/domain/repos/auth_repos.dart';

class LogoutUseCase extends UseCaseWithParams<void, String> {
  const LogoutUseCase(this._repos);

  final AuthRepos _repos;
  @override
  ResultFuture<void> call(String params) => _repos.logout(token: params);
}
