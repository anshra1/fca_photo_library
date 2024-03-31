import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fca_photo_library/core/auth/auth_error.dart';
import 'package:fca_photo_library/core/usecase/usecase.dart';
import 'package:fca_photo_library/src/auth/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithEmailAndpassword
    extends UseCaseWithParams<UserCredential, UserDataed> {
  const SignInWithEmailAndpassword({
    required this.authRepository,
  });

  final AuthenticationRepository authRepository;

  @override
  Future<Either<AuthError, UserCredential>> call({
    required UserDataed params,
  }) async {
    return authRepository.signWithEmailAndPasword(
      email: params.email,
      passord: params.password,
    );
  }
}

class UserDataed extends Equatable {
  final String email;
  final String password;

  const UserDataed({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
