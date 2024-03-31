// import 'package:fca_photo_library/src/auth/data/datasources/auth_remote_data_source.dart';
// import 'package:firebase_auth/firebase_auth.dart' as auth;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';


// class Mockuser extends Mock implements User {
//   Mockuser();
// }

// class MockFirebaseAuth extends Mock implements FirebaseAuth {
//   MockFirebaseAuth();
// }



// class MockUserCredential extends Mock implements auth.UserCredential {
//   MockUserCredential();
// }

// class MockAuthRepoRemoteSourceImpl extends Mock
//     implements AuthRepoRemoteDataSource {}

// void main() {
// // Include your file with the createUserWithEmailAndPassword function

//   test('createUserWithEmailAndPassword - Success', () async {
//     final mockAuth = MockFirebaseAuth();
//     final mockUser = MockUser(uid: 'test-uid', email: 'test@email.com');

//     when(mockAuth.createUserWithEmailAndPassword(
//             email: anyNamed('email'), password: anyNamed('password')))
//         .thenAnswer((_) => Future.value(MockUserCredential(user: mockUser)));

//     // Inject the mocked FirebaseAuth instance (replace fi with your actual instance)
//     final userCredential = await createUserWithEmailAndPassword(
//         fi: mockAuth, email: 'test@email.com', password: 'password');

//     expect(userCredential.user?.uid, 'test-uid');
//     expect(userCredential.user?.email, 'test@email.com');
//   });

//   // test('createUserWithEmailAndPassword - FirebaseAuthException', () async {
//   //   final mockAuth = MockFirebaseAuth();
//   //   final mockException = FirebaseAuthException(code: 'weak-password');

//   //   when(mockAuth.createUserWithEmailAndPassword(
//   //           email: anyNamed('email'), password: anyNamed('password')))
//   //       .thenThrow(mockException);

//   //   // Inject the mocked FirebaseAuth instance
//   //   expect(() => createUserWithEmailAndPassword(
//   //       fi: mockAuth,
//   //       email: 'test@email.com',
//   //       password: 'password')).toThrowWithMatcher(isA<AuthException>());
//   // });
// }
