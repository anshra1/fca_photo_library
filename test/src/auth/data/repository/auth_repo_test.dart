// ignore_for_file: unused_local_variable

import 'package:dartz/dartz.dart';
import 'package:fca_photo_library/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fca_photo_library/src/auth/data/repository/auth_repo_impl.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSrc extends Mock implements AuthRepoRemoteDataSource {}

class MockUserCredential extends Mock implements auth.UserCredential {
  MockUserCredential();
}

class CustomFirebaseException extends Mock implements FirebaseException {
  CustomFirebaseException();
}

const email = 'ansh321dddd@gmail.com';
const password = 'anshraj1';

void main() {
  late AuthRepoRemoteDataSource authRepoRemoteDataSource;
  late AuthenticationRepoImpl authremoteesrcIMpl;
  late auth.UserCredential credential;
  late FirebaseException firebaseException;

  setUp(
    () {
      authRepoRemoteDataSource = MockRemoteDataSrc();
      authremoteesrcIMpl =
          AuthenticationRepoImpl(remoteSource: authRepoRemoteDataSource);
      credential = MockUserCredential();
      firebaseException = CustomFirebaseException();
    },
  );

  group(
    'create user with email and password',
    () {
      test(
        'should return userCredential when sucessful ',
        () async {
          when(() => authRepoRemoteDataSource.createUserWithEmailAndpassword(
                email: email,
                password: password,
              )).thenAnswer(
            (invocation) async => credential,
          );

          final result =
              await authremoteesrcIMpl.createUserWithEmailAndpassword(
            email: email,
            passord: password,
          );

          expect(result, Right(credential));
        },
      );

      test(
        'should return AuthException when unsucessful ',
        () async {
          var e = auth.FirebaseAuthException(code: 'e');

          when(
            () => authRepoRemoteDataSource.createUserWithEmailAndpassword(
              email: email,
              password: password,
            ),
          ).thenThrow(
            auth.FirebaseAuthException(
              code: e.code,
              credential: credential.credential,
            ),
          );

          final result =
              await authremoteesrcIMpl.createUserWithEmailAndpassword(
            email: email,
            passord: password,
          );
         

          // expect(result, Left(AuthError(message: e)));
          // print(AuthError(message: e).toString());
          // print(AuthError(message: e).message.code.toLowerCase().trim());
        },
      );
    },
  );
}
