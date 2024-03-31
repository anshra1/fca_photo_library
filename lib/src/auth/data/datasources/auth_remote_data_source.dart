import 'dart:io';
import 'package:fca_photo_library/core/auth/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

abstract class AuthRepoRemoteDataSource {
  const AuthRepoRemoteDataSource();

  Future<List<Reference>> getImages({
    required String userId,
  });

  Future<bool> uploadImages({
    required File file,
    required String userId,
  });

  Future<UserCredential> signWithEmailAndPasword({
    required String email,
    required String passord,
  });

  Future<UserCredential> createUserWithEmailAndpassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
  Future<void> deleteAccount();
}

class AuthRepoRemoteDataSourceImpl extends AuthRepoRemoteDataSource {
  var fi = FirebaseAuth.instance;

  @override
  Future<UserCredential> createUserWithEmailAndpassword({
    required String email,
    required String password,
  }) async {
    try {
      final creadentials = await fi.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return creadentials;
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e);
    }
  }

  @override
  Future<List<Reference>> getImages({
    required String userId,
  }) {
    try {
      return FirebaseStorage.instance
          .ref(userId)
          .list()
          .then((listResult) => listResult.items);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e);
    }
  }

  // Future<Iterable<Reference>> imagesGet(String userId) =>
  //     FirebaseStorage.instance
  //         .ref(userId)
  //         .list()
  //         .then((listResult) => listResult.items);

  @override
  Future<void> signOut() async {
    fi.signOut();
  }

  @override
  Future<UserCredential> signWithEmailAndPasword({
    required String email,
    required String passord,
  }) async {
    try {
      final userCredential = await fi.signInWithEmailAndPassword(
        email: email,
        password: passord,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e);
    }
  }

  @override
  Future<bool> uploadImages({
    required File file,
    required String userId,
  }) async {
    return FirebaseStorage.instance
        .ref(userId)
        .child(const Uuid().v4())
        .putFile(file)
        .then((p0) => true)
        .catchError((_) => false);
  }

  @override
  Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser!;
    try {
      final folder = await FirebaseStorage.instance.ref(user.uid).listAll();
      for (final item in folder.items) {
        await item.delete();
      }

      await user.delete();
      // log the user out
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e);
    }
  }
}
