class Cache {
  Cache._();

  static final Cache instance = Cache._();

  String? _sessionToken;
  String? _userId;

  String? get sessionToken => _sessionToken;
  String? get userId => _userId;

  void setSessionToken(String newToken) {
    if (_sessionToken != newToken) _sessionToken = newToken;
  }

  void setUserId(String authenticatedUserId) {
    if (_userId != authenticatedUserId) _userId = authenticatedUserId;
  }

  void resetSessionToken() {
    _sessionToken = null;
    _userId = null;
  }
}
