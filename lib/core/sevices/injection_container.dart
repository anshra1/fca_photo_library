import 'package:fca_photo_library/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fca_photo_library/src/auth/data/repository/auth_repo_impl.dart';
import 'package:fca_photo_library/src/auth/domain/repositories/auth_repo.dart';
import 'package:fca_photo_library/src/auth/domain/usecases/create_user_email_and_password.dart';
import 'package:fca_photo_library/src/auth/domain/usecases/delete_account.dart';
import 'package:fca_photo_library/src/auth/domain/usecases/get_images.dart';
import 'package:fca_photo_library/src/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:fca_photo_library/src/auth/domain/usecases/upload_image.dart';
import 'package:fca_photo_library/src/auth/presentation/bloc/bloc/app_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  sl
    // application logic
    ..registerFactory(
      () => AppBloc(
          createUserWithEmailAndPassword: sl(),
          deleteAccount: sl(),
          signInWithEmailAndpassword: sl(),
          uploadImage: sl(),
          getImagesFF: sl()),
    )
    // usecases
    ..registerLazySingleton(() => CreateUserWithEmailAndPassword(
          authRepository: sl(),
        ))
    ..registerLazySingleton(() => DeleteAccount(
          authRepository: sl(),
        ))
    ..registerLazySingleton(() => SignInWithEmailAndpassword(
          authRepository: sl(),
        ))
    ..registerLazySingleton(() => UploadImage(
          authRepository: sl(),
        ))
    ..registerLazySingleton(() => GetImagesFF(
          authRepository: sl(),
        ))

    //repository
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepoImpl(
              remoteSource: sl(),
            ))

    // remote data source
    ..registerLazySingleton<AuthRepoRemoteDataSource>(
        () => AuthRepoRemoteDataSourceImpl());
}
