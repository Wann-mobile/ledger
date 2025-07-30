import 'package:equatable/equatable.dart';
import 'package:ledger/core/services/use_cases.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/domain/entities/auth_response.dart';
import 'package:ledger/src/auth/domain/repos/auth_repos.dart';

class LoginUseCase extends UseCaseWithParams<AuthResponse, LoginParams> {
  const LoginUseCase(this._repos);
  final AuthRepos _repos;
  @override
  ResultFuture<AuthResponse> call(LoginParams params) =>
      _repos.login(email: params.email, password: params.password);
}

class LoginParams extends Equatable {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
