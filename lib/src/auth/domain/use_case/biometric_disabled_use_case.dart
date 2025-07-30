import 'package:ledger/core/services/use_cases.dart';
import 'package:ledger/src/auth/data/repos_impl/auth_service.dart';

class BiometricDisabledUseCase extends FutureUseCaseWithOutParams<void> {
  const BiometricDisabledUseCase(this._authService);

  final AuthService _authService;

  @override
  Future<void> call() => _authService.disableBiometricLogin();
}
