import 'dart:convert';

import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/domain/entities/auth_response.dart';

class AuthResponseModel extends AuthResponse {
  const AuthResponseModel({required super.response});

  AuthResponseModel copyWith({required DataMap? response}) {
    return AuthResponseModel(response: response ?? this.response);
  }

  DataMap toMap() {
    return {'response': response};
  }

  factory AuthResponseModel.fromMap(DataMap map) {
    return AuthResponseModel(response: map);
  }

  AuthResponseModel.empty() : this(response: {});

  factory AuthResponseModel.fromJson(String source) =>
      AuthResponseModel.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());
}
