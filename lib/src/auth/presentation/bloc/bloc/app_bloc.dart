import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fca_photo_library/core/auth/auth_error.dart';
import 'package:fca_photo_library/src/auth/domain/usecases/create_user_email_and_password.dart';
import 'package:fca_photo_library/src/auth/domain/usecases/delete_account.dart';
import 'package:fca_photo_library/src/auth/domain/usecases/get_images.dart';
import 'package:fca_photo_library/src/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:fca_photo_library/src/auth/domain/usecases/upload_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required GetImagesFF getImagesFF,
    required CreateUserWithEmailAndPassword createUserWithEmailAndPassword,
    required DeleteAccount deleteAccount,
    required SignInWithEmailAndpassword signInWithEmailAndpassword,
    required UploadImage uploadImage,
  })  : _createUserWithEmailAndPassword = createUserWithEmailAndPassword,
        _getImages = getImagesFF,
        _deleteAccount = deleteAccount,
        _signInWithEmailAndpassword = signInWithEmailAndpassword,
        _uploadImage = uploadImage,
        super(const AppStateLoggedOut(isLoading: false)) {
    //

    on<AppEventRefresh>(_refreshTheHandler);
    on<AppEventRegister>(_registerTheUser);
    on<AppEventGoToLogIn>(_goToLoginScreen);
    on<AppEventGoToRegisteration>(_goToRegisterationScreen);
    on<AppEventInitialize>(_onAppEventIntializeToApp);
    on<AppEventLogOut>(_onLogOutFromUi);
    on<AppEventDeleteAccount>(_deleteAccountFromFirebase);
    on<AppEventLogIn>(_logInToFirebase);
    on<AppEventUploadImage>(_uploadImageToWeb);
  }

  final CreateUserWithEmailAndPassword _createUserWithEmailAndPassword;
  final DeleteAccount _deleteAccount;
  final SignInWithEmailAndpassword _signInWithEmailAndpassword;
  final UploadImage _uploadImage;
  final GetImagesFF _getImages;

  Future<void> _refreshTheHandler(
    AppEventRefresh event,
    Emitter<AppState> emit,
  ) async {
    emit(
      AppStateLoggedIn(
        user: state.user!,
        images: state.imagesd ?? [],
        isLoading: true,
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    final images = await _getImages(params: state.user!.uid);
    images.fold(
      (l) => null,
      (images) => emit(
        AppStateLoggedIn(
          user: state.user!,
          images: images,
          isLoading: false,
        ),
      ),
    );
  }

  Future<void> _onAppEventIntializeToApp(
    AppEventInitialize event,
    Emitter<AppState> emit,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(
        const AppStateLoggedOut(
          isLoading: false,
        ),
      );
    } else {
      // grab the user uploaded images

      await _getImages(params: user.uid).then(
        (result) => result.fold(
          (error) => AppStateLoggedIn(
            user: user,
            images: state.images ?? [],
            isLoading: false,
          ),
          (listOfImages) => emit(
            AppStateLoggedIn(
              user: user,
              images: listOfImages,
              isLoading: false,
            ),
          ),
        ),
      );
    }
  }

  Future<void> _uploadImageToWeb(
    AppEventUploadImage event,
    Emitter<AppState> emit,
  ) async {
    final user = state.user;
    // log user out if wee don't have an actual user in app state

    if (user == null) {
      emit(const AppStateLoggedOut(
        isLoading: false,
      ));
      return;
    }
    // start loading process

    emit(
      AppStateLoggedIn(
        user: user,
        images: state.images ?? [],
        isLoading: true,
      ),
    );

    final file = File(event.filePathToUpload);
    //   await uploadImaage(file: file, userId: user.uid);
    await _uploadImage(
      params: UploadData(
        userId: user.uid,
        filePath: file,
      ),
    ).then(
      (result) => result.fold(
        (error) => AppStateLoggedIn(
          user: user,
          images: state.images ?? [],
          isLoading: false,
        ),
        (voids) => null,
      ),
    );

    // after upload is complete grab the latest references
    //  final images = await imagesGet(user.uid);
    await _getImages(params: user.uid).then(
      (result) => result.fold(
        (error) => AppStateLoggedIn(
          user: user,
          images: state.images ?? [],
          isLoading: false,
        ),
        (images) => emit(
          AppStateLoggedIn(
            user: user,
            images: images,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  Future<void> _deleteAccountFromFirebase(
    AppEventDeleteAccount appEventGoToLogIn,
    Emitter<AppState> emit,
  ) async {
    emit(
      AppStateLoggedIn(
        user: state.user!,
        images: state.imagesd ?? [],
        isLoading: true,
      ),
    );

    await _deleteAccount();

    emit(
      const AppStateLoggedOut(
        isLoading: false,
      ),
    );
  }

  Future<void> _onLogOutFromUi(
    AppEventLogOut appEventGoToLogIn,
    Emitter<AppState> emit,
  ) async {
    emit(
      const AppStateLoggedOut(
        isLoading: true,
      ),
    );

    await FirebaseAuth.instance.signOut();

    emit(
      const AppStateLoggedOut(
        isLoading: false,
      ),
    );
  }

  Future<void> _goToRegisterationScreen(
    AppEventGoToRegisteration appEventGoToLogIn,
    Emitter<AppState> emit,
  ) async {
    emit(
      const AppStateIsInRegistrationView(
        isLoading: false,
      ),
    );
  }

  Future<void> _goToLoginScreen(
    AppEventGoToLogIn appEventGoToLogIn,
    Emitter<AppState> emit,
  ) async {
    emit(
      const AppStateLoggedOut(
        isLoading: false,
      ),
    );
  }

  Future<void> _logInToFirebase(
    AppEventLogIn event,
    Emitter<AppState> emit,
  ) async {
    emit(
      const AppStateLoggedOut(
        isLoading: true,
      ),
    ); // Uncomment for loading state

    final email = event.email;
    final password = event.password;

    var result = await _signInWithEmailAndpassword(
      params: UserDataed(
        email: email,
        password: password,
      ),
    );

    await result.fold(
      (authError) async {
        emit(
          AppStateLoggedOut(
            isLoading: false,
            authError: authError,
          ),
        );
      },
      (userCreadential) async {
        final user = userCreadential.user;

        final imageResult = await _getImages(params: user!.uid);

        imageResult.fold(
          (error) async => AppStateLoggedIn(
            user: user,
            images: state.images ?? [],
            isLoading: false,
          ),
          (images) async {
            emit(
              AppStateLoggedIn(
                user: user,
                images: images,
                isLoading: false,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _registerTheUser(
    AppEventRegister appEventRegister,
    Emitter<AppState> emit,
  ) async {
    emit(
      const AppStateIsInRegistrationView(
        isLoading: true,
      ),
    );

    final email = appEventRegister.email;
    final password = appEventRegister.password;

    await _createUserWithEmailAndPassword(
      params: UserData(
        email: email,
        password: password,
      ),
    ).then(
      (result) => result.fold(
        (error) => emit(
          AppStateIsInRegistrationView(
            isLoading: false,
            authError: error,
          ),
        ),
        (userCredential) => emit(
          AppStateLoggedIn(
            user: userCredential.user!,
            images: const [],
            isLoading: false,
          ),
        ),
      ),
    );
  }
}

extension GetUserd on AppState {
  User? get userd {
    final cls = this;
    if (cls is AppStateLoggedIn) {
      return cls.user;
    } else {
      return null;
    }
  }
}

extension GetImagesd on AppState {
  Iterable<Reference>? get imagesd {
    final cls = this;
    if (cls is AppStateLoggedIn) {
      return cls.images;
    } else {
      return null;
    }
  }
}
