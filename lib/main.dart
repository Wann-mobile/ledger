import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger/core/services/router_import.dart';
import 'package:ledger/src/auth/presentation/adapter/auth_bloc.dart';
import 'package:ledger/src/auth/presentation/adapter/auth_state.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Ledger',
          debugShowCheckedModeBanner: false,
          routerConfig: goRoute(state),
        );
      },
    );
  }
}
