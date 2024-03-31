import 'package:fca_photo_library/core/dialog/show_auth_error.dart';
import 'package:fca_photo_library/core/extension/if_dedug.dart';
import 'package:fca_photo_library/core/loading/loading_screen.dart';
import 'package:fca_photo_library/core/sevices/injection_container.dart';
import 'package:fca_photo_library/firebase_options.dart';
import 'package:fca_photo_library/src/auth/presentation/bloc/bloc/app_bloc.dart';
import 'package:fca_photo_library/src/auth/presentation/views/image_gallery_view.dart';
import 'package:fca_photo_library/src/auth/presentation/views/login_view.dart';
import 'package:fca_photo_library/src/auth/presentation/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (context) => sl<AppBloc>()
        ..add(
          const AppEventInitialize(),
        ),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            // brightness: Brightness.dark,
            // primarySwatch: Colors.blueGrey,
            // indicatorColor: Colors.blueGrey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const HomeScreen()),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen.instance().show(
            context: context,
            text: 'Loading...',
          );
        } else {
          LoadingScreen.instance().hide();
        }

        final authError = state.authError;
        authError.toString().log();
        if (authError != null) {
          showAuthError(
            authError: authError,
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state is AppStateLoggedOut) {
          return const LoginView();
        } else if (state is AppStateLoggedIn) {
          return const ImageGalleryView();
        } else if (state is AppStateIsInRegistrationView) {
          return const RegisterView();
        } else {
          return Container();
        }
      },
    );
  }
}
