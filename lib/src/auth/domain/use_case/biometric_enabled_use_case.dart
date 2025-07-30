import 'package:ledger/core/services/use_cases.dart';
import 'package:ledger/src/auth/data/repos_impl/auth_service.dart';

class BiometricEnabledUseCase extends FutureUseCaseWithOutParams<bool> {
  const BiometricEnabledUseCase(this._authService);

  final AuthService _authService;

  @override
  Future<bool> call() => _authService.enableBiometricLogin();
}
