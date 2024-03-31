import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthException extends Equatable implements Exception {
  final FirebaseAuthException message;

  const AuthException({required this.message});

  @override
  List<Object?> get props => [message];
}
