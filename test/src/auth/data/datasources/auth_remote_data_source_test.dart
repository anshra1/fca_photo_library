// import 'package:fca_photo_library/core/extension/if_dedug.dart';
// import 'package:fca_photo_library/src/auth/data/datasources/auth_remote_data_source.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:firebase_auth/firebase_auth.dart' as auth;

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

// const email = 'ansh321dddd@gmail.com';
// const password = 'anshraj1';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   late AuthRepoRemoteDataSource mockAuthRepoRemoteDataSource;
//   late FirebaseAuth firebaseAuth;
//   late User mockUser;
//   late auth.UserCredential userCredential;

//   setUp(
//     () {
//       mockAuthRepoRemoteDataSource = MockAuthRepoRemoteSourceImpl();
//       firebaseAuth = MockFirebaseAuth();
//       mockUser = Mockuser();
//       userCredential = MockUserCredential();
//     },
//   );

//   group(
//     'createUserWithEmailAndpassword',
//     () {
//       test(
//         'should return credential when authoRepoImpl.'
//         'crateUserWithEmailANdPassword is sucess',
//         () async {
//           //act

//           when(
//             () => mockAuthRepoRemoteDataSource.createUserWithEmailAndpassword(
//               email: email,
//               password: password,
//             ),
//           ).thenAnswer(
//             (_) async => Future.value(userCredential),
//           );

//           // arrange
//           final result =
//               await mockAuthRepoRemoteDataSource.createUserWithEmailAndpassword(
//             email: email,
//             password: password,
//           );

//           result.log;

//           // assert
//           expect(result, userCredential);
//         },
//       );
//     },
//   );

  
// }
