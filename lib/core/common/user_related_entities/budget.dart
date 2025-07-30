import 'package:equatable/equatable.dart';

class BudgetEntity extends Equatable {
  const BudgetEntity({required this.amount, required this.timeframe});

  final double amount;
  final String timeframe;

  @override
  List<Object?> get props => [amount, timeframe];
}
