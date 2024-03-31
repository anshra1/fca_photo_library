import 'package:dartz/dartz.dart';
import 'package:fca_photo_library/core/auth/auth_error.dart';
import 'package:fca_photo_library/core/usecase/usecase.dart';
import 'package:fca_photo_library/src/auth/domain/repositories/auth_repo.dart';

class SignOut extends UseCaseWithoutParam<void> {
  final AuthenticationRepository authRepository;

  const SignOut({
    required this.authRepository,
  });

  @override
  Future<Either<AuthError, void>> call() async {
    return authRepository.signOut();
  }
}
