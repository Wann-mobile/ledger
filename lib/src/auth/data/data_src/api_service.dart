import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ledger/core/common/constants/app_constants.dart';
import 'package:ledger/core/common/user_related_entities/budget.dart';
import 'package:ledger/core/common/user_related_entities/business_info.dart';
import 'package:ledger/core/errors/auth_exceptions.dart';
import 'package:ledger/core/utils/typedefs.dart';
import 'package:ledger/src/auth/data/model/auth_response_model.dart';

abstract class ApiService {
  const ApiService();

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  Future<String> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String accountType,
    required BudgetEntity budget,
    BusinessInfoEntity? businessInfo,
  });

  Future<AuthResponseModel> verifyEmail({
    required String email,
    required String otp,
  });

  Future<void> logout({required String token});

  Future<String> refreshToken({required String currentToken});

  Future<void> forgotPassword({required String email});

  Future<String> verifyOtp({required String email, required String otp});

  Future<void> resetpassword({
    required String resetToken,
    required String newPassword,
  });

  void setAuthToken(String token);

  void clearAuthToken();
}

// class ApiServicee {

//   ApiServicee();

// // Transaction APIs
// Future<TransactionResponse> getTransactions({
//   int page = 1,
//   int limit = 20,
//   DateTime? startDate,
//   DateTime? endDate,
// }) async {
//   try {
//     final queryParams = <String, dynamic>{
//       'page': page,
//       'limit': limit,
//     };

//     if (startDate != null) {
//       queryParams['startDate'] = startDate.toIso8601String();
//     }
//     if (endDate != null) {
//       queryParams['endDate'] = endDate.toIso8601String();
//     }

//     final response = await _dio.get('/transactions', queryParameters: queryParams);

//     return TransactionResponse.fromJson(response.data);
//   } on DioException catch (e) {
//     throw _handleDioError(e);
//   }
// }

// Future<void> syncTransactions(List<Transaction> transactions) async {
//   try {
//     final data = {
//       'transactions': transactions.map((t) => t.toJson()).toList(),
//     };

//     await _dio.post('/transactions/sync', data: data);
//   } on DioException catch (e) {
//     throw _handleDioError(e);
//   }
// }

// Future<void> updateTransactionCategory(String transactionId, String category) async {
//   try {
//     await _dio.patch('/transactions/$transactionId', data: {
//       'category': category,
//     });
//   } on DioException catch (e) {
//     throw _handleDioError(e);
//   }
// }

// // Analytics APIs
// Future<AnalyticsData> getAnalytics({
//   DateTime? startDate,
//   DateTime? endDate,
//   String timeframe = 'monthly',
//   bool showPercentage = false,
// }) async {
//   try {
//     final queryParams = <String, dynamic>{
//       'timeframe': timeframe,
//       'showPercentage': showPercentage,
//     };

//     if (startDate != null) {
//       queryParams['startDate'] = startDate.toIso8601String();
//     }
//     if (endDate != null) {
//       queryParams['endDate'] = endDate.toIso8601String();
//     }

//     final response = await _dio.get('/analytics', queryParameters: queryParams);

//     return AnalyticsData.fromJson(response.data);
//   } on DioException catch (e) {
//     throw _handleDioError(e);
//   }
// }

// // User APIs
// Future<User> updateProfile(Map<String, dynamic> userData) async {
//   try {
//     final response = await _dio.patch('/user/profile', data: userData);
//     return User.fromJson(response.data['user']);
//   } on DioException catch (e) {
//     throw _handleDioError(e);
//   }
// }
// }

class ApiServiceImpl implements ApiService {
  ApiServiceImpl() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  late final Dio _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('🚀 ${options.method} ${options.path}');
          if (options.data != null) {
            debugPrint('📤 Data: ${options.data}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
            '✅ ${response.statusCode} ${response.requestOptions.path}',
          );
          handler.next(response);
        },
        onError: (error, handler) {
          debugPrint(
            '❌ ${error.response?.statusCode} ${error.requestOptions.path}',
          );
          debugPrint('Error: ${error.response?.data}');
          handler.next(error);
        },
      ),
    );
  }

  @override
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _dio.post(
        '${AppConstants.baseUrl}/auth/forgot-password',
        data: {'email': email},
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/auth/login',
        data: {'email': email, 'password': password},
      );

      final payload = response.data as DataMap;
      final loginResponse = AuthResponseModel.fromMap(payload);

      return loginResponse;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> logout({required String token}) async {
    try {
      await _dio.post(
        '${AppConstants.baseUrl}/auth/logout',
        data: {'token': token},
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<String> refreshToken({required String currentToken}) async {
    try {
      final response = await _dio.post('${AppConstants.baseUrl}/auth/refresh');
      return response.data['token'] as String;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<String> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String accountType,
    required BudgetEntity budget,
    BusinessInfoEntity? businessInfo,
  }) async {
    try {
      final data = {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'accountType': accountType,
        'budget': budget,
      };

      if (businessInfo != null) {
        data['businessInfo'] = businessInfo;
      }

      final emailToVerify = await _dio.post(
        '${AppConstants.baseUrl}/auth/register',
        data: data,
      );

      return emailToVerify.data['email'];
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> resetpassword({
    required String resetToken,
    required String newPassword,
  }) async {
    try {
      await _dio.post(
        '${AppConstants.baseUrl}/auth/reset-password',
        data: {'resetToken': resetToken, 'newPassword': newPassword},
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<AuthResponseModel> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/auth/verify-email',
        data: {'email': email, 'otp': otp},
      );
      final payload = response.data as DataMap;
      final verifyEmailResponse = AuthResponseModel.fromMap(payload);

      return verifyEmailResponse;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<String> verifyOtp({required String email, required String otp}) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/auth/verify-otp',
        data: {'email': email, 'otp': otp},
      );
      return response.data['resetToken'];
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  ApiException _handleDioError(DioException e) {
    if (e.response != null) {
      final data = e.response!.data;
      return ApiException(
        message: data['message'] ?? data['error'] ?? 'Unknown error occurred',
        statusCode: e.response!.statusCode,
        code: data['code']?.toString(),
      );
    } else {
      return ApiException(message: 'Network error: ${e.message}');
    }
  }
}
