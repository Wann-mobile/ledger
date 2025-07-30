import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger/core/app_theme/theme.dart';
import 'package:ledger/core/common/providers/session_provider.dart';
import 'package:ledger/core/services/router_import.dart';
import 'package:ledger/src/auth/presentation/adapter/auth_bloc.dart';
import 'package:ledger/src/auth/presentation/adapter/auth_state.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return Consumer<SessionProvider>(
          builder: (_, sessionProvider, __) {
            return MaterialApp.router(
              title: 'Ledgr',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: sessionProvider.themeMode ?? ThemeMode.system,
              debugShowCheckedModeBanner: false,
              routerConfig: goRoute(authState),
            );
          },
        );
      },
    );
  }
}
