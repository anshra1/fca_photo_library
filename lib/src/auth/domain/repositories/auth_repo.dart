import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fca_photo_library/core/auth/auth_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  Future<Either<AuthError, List<Reference>>> getImages({
    required String userId,
  });

  Future<Either<AuthError, void>> uploadImages({
    required File file,
    required String userId,
  });

  Future<Either<AuthError, UserCredential>> signWithEmailAndPasword({
    required String email,
    required String passord,
  });

  Future<Either<AuthError, UserCredential>> createUserWithEmailAndpassword({
    required String email,
    required String passord,
  });

  Future<Either<AuthError, void>> signOut();

  Future<Either<AuthError, void>> deleteAccount(
    
  );
}
