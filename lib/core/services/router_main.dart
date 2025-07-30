part of 'router_import.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
GoRouter goRoute(AuthState authState) {
  return GoRouter(
    initialLocation: '/',
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) {
          return switch (authState) {
            AuthStateOnboardingRequired() => OnboardingScreen.path,
            AuthStateAuthenticated() => HomeView.path,
            AuthStateLoggedOut() => LoginScreen.path,
            AuthStateRegistration() => RegistrationScreen.path,
            AuthStateEmailVerification() => EmailVerificationScreen.path,
            AuthStateInitial() => '/',
            _ => '/',
          };
        },
        builder: (context, state) {
          return SplashScreen();
        },
      ),
      GoRoute(path: LoginScreen.path, builder: (_, __) => const LoginScreen()),
      GoRoute(
        path: RegistrationScreen.path,
        builder: (_, __) => const RegistrationScreen(),
      ),
      GoRoute(
        path: ForgotPasswordScreen.path,
        builder: (_, __) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: ResetPasswordScreen.path,
        builder: (_, state) => ResetPasswordScreen(),
      ),
      GoRoute(
        path: VerifyOtpScreen.path,
        builder: (_, state) => VerifyOtpScreen(),
      ),

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainNav(state: state, child: child);
        },
        routes: [
          GoRoute(path: HomeView.path, builder: (_, __) => HomeView()),
          GoRoute(
            path: StatisticsView.path,
            builder: (_, __) => StatisticsView(),
          ),
          GoRoute(
            path: StatementsView.path,
            builder: (_, __) => StatementsView(),
          ),
          GoRoute(path: ProfileView.path, builder: (_, __) => ProfileView()),
        ],
      ),
    ],
  );
}
