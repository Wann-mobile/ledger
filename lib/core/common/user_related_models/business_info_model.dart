import 'dart:convert';

import 'package:ledger/core/common/user_related_entities/business_info.dart';
import 'package:ledger/core/utils/typedefs.dart';

class BusinessInfoModel extends BusinessInfoEntity {
  const BusinessInfoModel({
    super.businessName,
    super.tradingName,
    super.businessEmail,
  });

  const BusinessInfoModel.empty()
    : this(businessName: '', businessEmail: '', tradingName: '');

  BusinessInfoModel copyWith({
    String? businessName,
    String? tradingName,
    String? businessEmail,
  }) {
    return BusinessInfoModel(
      businessName: businessName ?? this.businessName,
      businessEmail: businessEmail ?? this.businessEmail,
      tradingName: tradingName ?? this.tradingName,
    );
  }

  DataMap toMap() {
    return {
      'name': businessName,
      'tradingName': tradingName,
      'businessEmail': businessEmail,
    };
  }

  BusinessInfoModel.fromMap(DataMap map)
    : this(
        businessName: map['businessName'],
        businessEmail: map['businessEmail'],
        tradingName: map['tradingName'],
      );

  factory BusinessInfoModel.fromJson(String source) =>
      BusinessInfoModel.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());
}
