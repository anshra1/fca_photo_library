
import 'package:fca_photo_library/core/dialog/delele_account_dialog.dart';
import 'package:fca_photo_library/core/dialog/log_out_dialog.dart';
import 'package:fca_photo_library/src/auth/presentation/bloc/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MenuAction { logout, deleteAccount }

class MainPopMenuButton extends StatelessWidget {
  const MainPopMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (value) async {
        switch (value) {
          case MenuAction.logout:
            final shouldLogout = await showLogOutDialog(context);

            if (shouldLogout) {
              // ignore: use_build_context_synchronously
              context.read<AppBloc>().add(const AppEventLogOut());
            }
            break;
          case MenuAction.deleteAccount:
            final shouldDelete = await showDeleteAccountDialog(context);

            if (shouldDelete) {
              // ignore: use_build_context_synchronously
              context.read<AppBloc>().add(const AppEventDeleteAccount());
            }
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuAction>(
            value: MenuAction.logout,
            child: Text('Log out'),
          ),
          const PopupMenuItem<MenuAction>(
            value: MenuAction.deleteAccount,
            child: Text('Delete Account'),
          ),
        ];
      },
    );
  }
}
