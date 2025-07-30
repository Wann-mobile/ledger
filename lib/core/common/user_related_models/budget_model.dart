import 'dart:convert';

import 'package:ledger/core/common/user_related_entities/budget.dart';
import 'package:ledger/core/utils/typedefs.dart';

class BudgetModel extends BudgetEntity {
  const BudgetModel({required super.amount, required super.timeframe});

  const BudgetModel.empty() : this(amount: 0.0, timeframe: '');

  BudgetModel copyWith({double? amount, String? timeframe}) {
    return BudgetModel(
      amount: amount ?? this.amount,
      timeframe: timeframe ?? this.timeframe,
    );
  }

  DataMap toMap() {
    return {'amount': amount, 'timeframe': timeframe};
  }

  BudgetModel.fromMap(DataMap map)
    : this(amount: map['amount'], timeframe: map['timeframe']);

  factory BudgetModel.fromJson(String source) =>
      BudgetModel.fromMap(jsonDecode(source) as DataMap);

  String toJson() => jsonEncode(toMap());
}
