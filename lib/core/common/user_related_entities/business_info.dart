import 'package:equatable/equatable.dart';

class BusinessInfoEntity extends Equatable {
  const BusinessInfoEntity({
    this.businessName,
    this.tradingName,
    this.businessEmail,
  });

  final String? businessName;
  final String? tradingName;
  final String? businessEmail;

  bool get isEmpty =>
      businessName == null && tradingName == null && businessEmail == null;
  bool get isNotEmpty => !isEmpty;
  @override
  List<Object?> get props => [businessName, tradingName, businessEmail];
}
