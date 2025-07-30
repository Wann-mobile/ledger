part of 'injection_container_import.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await authInit();
  await storageInit();
  // final Telephony telephony = Telephony.instance;
  // await telephony.requestPhoneAndSmsPermissions;
}

Future<void> authInit() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        forgotPassword: sl(),
        login: sl(),
        logout: sl(),
        refreshToken: sl(),
        register: sl(),
        resetpassword: sl(),
        verifyEmail: sl(),
        verifyOtp: sl(),
        biometricLoginUseCase: sl(),
        biometricDisabledUseCase: sl(),
        biometricEnabledUseCase: sl(),
      ),
    )
    ..registerLazySingleton(() => ForgotPasswordUseCase(sl()))
    ..registerLazySingleton(() => LoginUseCase(sl()))
    ..registerLazySingleton(() => LogoutUseCase(sl()))
    ..registerLazySingleton(() => RefreshTokenUseCase(sl()))
    ..registerLazySingleton(() => RegisterUseCase(sl()))
    ..registerLazySingleton(() => ResetPasswordUseCase(sl()))
    ..registerLazySingleton(() => VerifyEmailUseCase(sl()))
    ..registerLazySingleton(() => VerifyOtpUseCase(sl()))
    ..registerLazySingleton(() => BiometricLoginUseCase(sl()))
    ..registerLazySingleton(() => BiometricEnabledUseCase(sl()))
    ..registerLazySingleton(() => BiometricDisabledUseCase(sl()));
}

Future<void> storageInit() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerLazySingleton(() => StorageService(sl()))
    ..registerLazySingleton(() => prefs)
    ..registerLazySingleton(() => SessionProvider(sl()));
}
