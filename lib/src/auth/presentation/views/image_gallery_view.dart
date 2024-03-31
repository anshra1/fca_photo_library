import 'package:fca_photo_library/src/auth/presentation/bloc/bloc/app_bloc.dart';
import 'package:fca_photo_library/src/auth/presentation/views/main_popup_menu_button.dart';
import 'package:fca_photo_library/src/auth/presentation/views/storage_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class ImageGalleryView extends HookWidget {
  const ImageGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final picker = useMemoized(() => ImagePicker(), [key]);
    final images = context.watch<AppBloc>().state.images ?? [];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AppBloc>().add(
                const AppEventRefresh(),
              );
        },
        child: const Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: const Text('Image Gallary'),
        actions: [
          IconButton(
            onPressed: () async {
              final image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image == null) {
                return;
              }

              // ignore: use_build_context_synchronously
              context.read<AppBloc>().add(
                    AppEventUploadImage(
                      filePathToUpload: image.path,
                    ),
                  );
            },
            icon: const Icon(
              Icons.upload,
            ),
          ),
          const MainPopMenuButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AppBloc>().add(
                const AppEventRefresh(),
              );
          
        },
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(8),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: images
              .map(
                (img) => StorageImageView(
                  image: img,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
