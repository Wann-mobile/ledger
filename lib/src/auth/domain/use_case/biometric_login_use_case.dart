import 'package:ledger/core/services/use_cases.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/data/repos_impl/auth_service.dart';
import 'package:ledger/src/auth/domain/entities/auth_response.dart';

class BiometricLoginUseCase extends UseCaseWithOutParams<AuthResponse> {
  const BiometricLoginUseCase(this._authService);

  final AuthService _authService;

  @override
  ResultFuture<AuthResponse> call() => _authService.loginWithBiometrics();
}
