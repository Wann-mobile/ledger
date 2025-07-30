import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ledger/core/common/singleton/cache.dart';
import 'package:ledger/core/extension/string_ext.dart';
import 'package:ledger/core/extension/theme_ext.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService(this._prefs);
  final SharedPreferences _prefs;

  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const String _isFirstTimeKey = 'is-user-first-time';

  // Token management
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
    Cache.instance.setSessionToken(token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }

  // User data management
  Future<void> saveUserData(DataMap userData) async {
    final userJson = jsonEncode(userData);
    await _secureStorage.write(key: 'user_data', value: userJson);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final userJson = await _secureStorage.read(key: 'user_data');
    if (userJson != null) {
      return jsonDecode(userJson) as DataMap;
    }
    return null;
  }

  Future<void> clearUserData() async {
    await _secureStorage.delete(key: 'user_data');
  }

  Future<void> saveFirstTimer() async {
    await _prefs.setBool(_isFirstTimeKey, false);
  }

  bool isFirstTimer() {
    return _prefs.getBool(_isFirstTimeKey) ?? true;
  }

  // Biometric preferences
  Future<void> saveBiometricPreference(bool enabled) async {
    await _prefs.setBool('biometric_enabled', enabled);
  }

  Future<bool> getBiometricPreference() async {
    return _prefs.getBool('biometric_enabled') ?? false;
  }

  // Store credentials (for biometric login)
  Future<void> saveLoginCredentials({
    required String email,
    required String password,
  }) async {
    await _secureStorage.write(key: 'stored_email', value: email);
    await _secureStorage.write(key: 'stored_password', value: password);
  }

  // Get stored email
  Future<String?> getStoredEmail() async {
    return await _secureStorage.read(key: 'stored_email');
  }

  // Get stored password
  Future<String?> getStoredPassword() async {
    return await _secureStorage.read(key: 'stored_password');
  }

  // Clear stored credentials (on logout or when user disables biometric login)
  Future<void> clearStoredCredentials() async {
    await _secureStorage.delete(key: 'stored_email');
    await _secureStorage.delete(key: 'stored_password');
  }

  // App preferences
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _prefs.setString('theme_mode', themeMode.themeToString);
  }

  Future<ThemeMode> getThemeMode() async {
    final themeModeStringValue = _prefs.getString('theme_mode');
    final themeMode =
        themeModeStringValue?.stringToThemeMode ?? ThemeMode.system;

    return themeMode;
  }

  Future<void> saveLanguage(String languageCode) async {
    await _prefs.setString('language', languageCode);
  }

  Future<String> getLanguage() async {
    return _prefs.getString('language') ?? 'en';
  }

  // Clear all data
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
    await _prefs.clear();
  }
}
