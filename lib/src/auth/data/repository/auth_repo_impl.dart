import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fca_photo_library/core/auth/auth_error.dart';
import 'package:fca_photo_library/core/auth/auth_exception.dart';

import 'package:fca_photo_library/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fca_photo_library/src/auth/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthenticationRepoImpl implements AuthenticationRepository {
  final AuthRepoRemoteDataSource remoteSource;

  AuthenticationRepoImpl({
    required this.remoteSource,
  });

  @override
  Future<Either<AuthError, UserCredential>> createUserWithEmailAndpassword({
    required String email,
    required String passord,
  }) async {
    try {
      final credential = await remoteSource.createUserWithEmailAndpassword(
        email: email,
        password: passord,
      );
      return Right(credential);
    } on AuthException catch (e) {
      return Left(AuthError.from(e.message));
    }
  }

  @override
  Future<Either<AuthError, void>> deleteAccount() async {
    try {
      await remoteSource.deleteAccount();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthError.from(e.message));
    }
  }

  @override
  Future<Either<AuthError, List<Reference>>> getImages({
    required String userId,
  }) async {
    try {
      final image = await remoteSource.getImages(userId: userId);
      return Right(image);
    } on AuthException catch (e) {
      return Left(AuthError.from(e.message));
    }
  }

  @override
  Future<Either<AuthError, void>> signOut() async {
    try {
      remoteSource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthError.from(e.message));
    }
  }

  @override
  Future<Either<AuthError, UserCredential>> signWithEmailAndPasword({
    required String email,
    required String passord,
  }) async {
    try {
      final creadential = await remoteSource.signWithEmailAndPasword(
        email: email,
        passord: passord,
      );
      return Right(creadential);
    } on AuthException catch (e) {
      return Left(AuthError.from(e.message));
    }
  }

  @override
  Future<Either<AuthError, void>> uploadImages({
    required File file,
    required String userId,
  }) async {
    try {
      await remoteSource.uploadImages(
        file: file,
        userId: userId,
      );
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthError.from(e.message));
    }
  }
}
