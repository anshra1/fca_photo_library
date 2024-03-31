import 'package:dartz/dartz.dart';
import 'package:fca_photo_library/core/auth/auth_error.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();
  Future<Either<AuthError, Type>> call({required Params params});
}

abstract class UseCaseWithoutParam<Type> {
  const UseCaseWithoutParam();
  Future<Either<AuthError, Type>> call();
}
