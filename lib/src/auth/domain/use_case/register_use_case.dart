import 'package:equatable/equatable.dart';
import 'package:ledger/core/common/user_related_entities/budget.dart';
import 'package:ledger/core/common/user_related_entities/business_info.dart';
import 'package:ledger/core/services/use_cases.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/domain/repos/auth_repos.dart';

class RegisterUseCase extends UseCaseWithParams<String, RegisterParams> {
  const RegisterUseCase(this._repos);
  final AuthRepos _repos;
  @override
  ResultFuture<String> call(RegisterParams params) => _repos.register(
    name: params.name,
    email: params.email,
    password: params.password,
    phone: params.phone,
    accountType: params.accountType,
    budget: params.budget,
  );
}

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.accountType,
    required this.budget,
    this.businessInfo,
  });

  final String name;
  final String email;
  final String password;
  final String phone;
  final String accountType;
  final BudgetEntity budget;
  final BusinessInfoEntity? businessInfo;

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    phone,
    accountType,
    budget,
    businessInfo,
  ];
}
