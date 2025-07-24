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
            AuthLoading() => '/',
            AuthLoggedin() => '/home',
            AuthLoggedOut() => '/login',
            AuthRegistered() => '/register',
            AuthInitial() => '/',
            _ => '/',
          };
        },
        builder: (context, state) {
          return const MainApp();
        },
      
      ),
       GoRoute(
        path: '/login',
       ),
       GoRoute(path: '/register'),
      GoRoute(path: '/home', ),

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        // builder: (context, state, child) {
          
        // },
       routes: [
          GoRoute( 
            path: '/home',
      )]
      )
    ],
  );
}
