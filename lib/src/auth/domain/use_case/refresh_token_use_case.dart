import 'package:ledger/core/services/use_cases.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/domain/repos/auth_repos.dart';

class RefreshTokenUseCase extends UseCaseWithParams<void, String> {
  const RefreshTokenUseCase(this._repos);

  final AuthRepos _repos;
  @override
  ResultFuture<void> call(String params) =>
      _repos.refreshToken(currentToken: params);
}
