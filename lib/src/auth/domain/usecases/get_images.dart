import 'package:dartz/dartz.dart';
import 'package:fca_photo_library/core/auth/auth_error.dart';
import 'package:fca_photo_library/core/usecase/usecase.dart';
import 'package:fca_photo_library/src/auth/domain/repositories/auth_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GetImagesFF extends UseCaseWithParams<Iterable<Reference>, String> {
  final AuthenticationRepository authRepository;

  const GetImagesFF({
    required this.authRepository,
  });

  @override
  Future<Either<AuthError, List<Reference>>> call({
    required String params,
  }) {
    return authRepository.getImages(
      userId: params,
    );
  }
}
