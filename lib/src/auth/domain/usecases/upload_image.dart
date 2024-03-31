import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fca_photo_library/core/auth/auth_error.dart';
import 'package:fca_photo_library/core/usecase/usecase.dart';
import 'package:fca_photo_library/src/auth/domain/repositories/auth_repo.dart';

class UploadImage extends UseCaseWithParams<void, UploadData> {
  final AuthenticationRepository authRepository;

  const UploadImage({
    required this.authRepository,
  });

  @override
  Future<Either<AuthError, void>> call({required UploadData params}) async {
    return authRepository.uploadImages(
      file: params.filePath,
      userId: params.userId,
    );
  }
}

class UploadData extends Equatable {
  final String userId;
  final File filePath;

  const UploadData({
    required this.userId,
    required this.filePath,
  });

  @override
  List<Object?> get props => [userId, filePath];
}
