// lib/providers/session_provider.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ledger/core/common/user_related_models/user_model.dart';
import 'package:ledger/core/common/app/service_storage.dart';
import 'package:ledger/core/utils/typedefs.dart';

class SessionProvider extends ChangeNotifier {
  final StorageService _storageService;

  String? _token;
  User? _user;
  bool _isBiometricEnabled = false;
  ThemeMode? _themeMode;
  SessionProvider(this._storageService) {
    _loadSession();
  }

  // Getters
  String? get token => _token;
  User? get user => _user;
  bool get isAuthenticated => _token != null && _user != null;
  bool get isBiometricEnabled => _isBiometricEnabled;
  ThemeMode? get themeMode => _themeMode;

  // Load session data from secure storage
  Future<void> _loadSession() async {
    try {
      _token = await _storageService.getToken();
      final userData = await _storageService.getUserData();
      if (userData != null) {
        _user = User.fromMap(userData);
      }
      _isBiometricEnabled = await _storageService.getBiometricPreference();
      _themeMode = await _storageService.getThemeMode();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading session: $e');
    }
  }

  // Save session data
  Future<void> setSession(String token, User user) async {
    try {
      _token = token;
      _user = user;

      await _storageService.saveToken(token);
      await _storageService.saveUserData(user.toMap());

      notifyListeners();
    } catch (e) {
      debugPrint('Error saving session: $e');
      throw Exception('Failed to save session');
    }
  }

  // Update user data
  Future<void> updateUser(User user) async {
    try {
      _user = user;
      await _storageService.saveUserData(user.toMap());
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating user: $e');
      throw Exception('Failed to update user');
    }
  }

  // Clear session data
  Future<void> clearSession() async {
    try {
      _token = null;
      _user = null;

      await _storageService.clearToken();
      await _storageService.clearUserData();

      notifyListeners();
    } catch (e) {
      debugPrint('Error clearing session: $e');
    }
  }

  // Biometric preferences
  Future<void> setBiometricPreference(bool enabled) async {
    try {
      _isBiometricEnabled = enabled;
      await _storageService.saveBiometricPreference(enabled);
      notifyListeners();
    } catch (e) {
      debugPrint('Error setting biometric preference: $e');
    }
  }

  Future<void> saveThemeModePref(ThemeMode themeMode) async {
    try {
      _themeMode = themeMode;
      await _storageService.saveThemeMode(themeMode);
      notifyListeners();
    } catch (e) {
      debugPrint('Error setting biometric preference: $e');
    }
  }

  // Check if token is expired (basic check)
  bool isTokenExpired() {
    if (_token == null) return true;

    try {
      // Basic JWT expiration check
      final parts = _token!.split('.');
      if (parts.length != 3) return true;

      final payload = parts[1];
      // Add padding if needed
      String normalized = base64.normalize(payload);
      final decoded = base64.decode(normalized);
      final payloadMap = DataMap.from(
        const JsonDecoder().convert(String.fromCharCodes(decoded)),
      );

      final exp = payloadMap['exp'] as int?;
      if (exp == null) return true;

      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return now >= exp;
    } catch (e) {
      debugPrint('Error checking token expiration: $e');
      return true;
    }
  }
}
