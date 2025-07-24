import 'package:bloc/bloc.dart';
import 'package:ledger/src/auth/presentation/adapter/auth_event.dart';
import 'package:ledger/src/auth/presentation/adapter/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent , AuthState>{
   AuthBloc() : super(const AuthInitial());
}