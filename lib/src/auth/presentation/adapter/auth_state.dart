import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable{
const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();

}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthLoggedin extends AuthState {
  const AuthLoggedin();
}

final class AuthLoggedOut extends AuthState{
  const AuthLoggedOut();
}

final class AuthRegistered extends AuthState {
  const AuthRegistered();
}

final class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
} 