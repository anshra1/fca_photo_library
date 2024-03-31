import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fca_photo_library/core/auth/auth_error.dart';
import 'package:fca_photo_library/core/usecase/usecase.dart';
import 'package:fca_photo_library/src/auth/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateUserWithEmailAndPassword
    extends UseCaseWithParams<UserCredential, UserData> {
  const CreateUserWithEmailAndPassword({
    required this.authRepository,
  });

  final AuthenticationRepository authRepository;

  @override
  Future<Either<AuthError, UserCredential>> call({
    required UserData params,
  }) async {
    return authRepository.createUserWithEmailAndpassword(
      email: params.email,
      passord: params.password,
    );
  }
}

class UserData extends Equatable {
  final String email;
  final String password;

  const UserData({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
