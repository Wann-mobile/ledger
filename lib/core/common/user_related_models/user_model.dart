import 'dart:convert';

import 'package:ledger/core/common/user_related_entities/budget.dart';
import 'package:ledger/core/common/user_related_entities/business_info.dart';
import 'package:ledger/core/common/user_related_entities/user.dart';
import 'package:ledger/core/common/user_related_models/budget_model.dart';
import 'package:ledger/core/common/user_related_models/business_info_model.dart';
import 'package:ledger/core/utils/typedefs.dart';

class User extends UserEntity {
  const User({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.accountType,
    required super.budget,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
    super.businessInfo,
    super.lastLogin,
  });

  User.empty()
    : this(
        id: '',
        name: '',
        email: '',
        phone: '',
        accountType: '',
        budget: BudgetEntity(amount: 0.0, timeframe: ''),
        businessInfo: BusinessInfoEntity(
          businessEmail: '',
          businessName: '',
          tradingName: '',
        ),
        isActive: true,
        lastLogin: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? accountType,
    BudgetEntity? budget,
    BusinessInfoEntity? businessInfo,
    bool? isActive,
    DateTime? lastLogin,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      accountType: accountType ?? this.accountType,
      businessInfo: businessInfo ?? this.businessInfo,
      budget: budget ?? this.budget,
      lastLogin: lastLogin ?? this.lastLogin,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'accountType': accountType,
      'businessInfo': (businessInfo as BusinessInfoModel).toMap(),
      'budget': (budget as BudgetModel).toMap(),
      'isActive': isActive,
      'lastLogin': lastLogin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory User.fromJson(String source) =>
      User.fromMap(jsonDecode(source) as DataMap);

  factory User.fromMap(DataMap map) {
    final budget = BudgetModel.fromMap({
      if (map case {'amount': double amount}) 'amount': amount,
      if (map case {'timeframe': String timeframe}) 'timeframe': timeframe,
    });
    final businessInfo = BusinessInfoModel.fromMap({
      if (map case {'businessName': String businessName})
        'businessName': businessName,
      if (map case {'businessEmail': String businessEmail})
        'businessEmail': businessEmail,
      if (map case {'tradingName': String tradingName})
        'tradingName': tradingName,
    });
    return User(
      id: map['id'] as String? ?? map['_id'] as String,
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      accountType: map['accountType'],
      budget: budget,
      businessInfo: businessInfo.isEmpty ? null : businessInfo,
      isActive: map['isActive'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      lastLogin: map['lastLogin'],
    );
  }

  String toJson() => jsonEncode(toMap());
}
