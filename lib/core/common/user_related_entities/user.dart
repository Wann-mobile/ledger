import 'package:equatable/equatable.dart';
import 'package:ledger/core/common/user_related_entities/budget.dart';
import 'package:ledger/core/common/user_related_entities/business_info.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.accountType,
    required this.budget,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.businessInfo,
    this.lastLogin,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String accountType;
  final BudgetEntity budget;
  final BusinessInfoEntity? businessInfo;
  final bool isActive;
  final DateTime? lastLogin;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    accountType,
    budget,
    businessInfo,
    isActive,
    lastLogin,
    createdAt,
    updatedAt,
  ];
}
