import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/ui/screens/home/bloc/home/home_bloc.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';
import 'package:open_filex/open_filex.dart';

class GradeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GradeAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: AppColors.grey3,
        ),
        onPressed: () {
          context.read<HomeBloc>().add(HomeMenuPressedEvent());
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            icon: const Icon(
              Icons.help_outline,
              color: AppColors.grey3,
              size: 25,
            ),
            onPressed: () {
              OpenFilex.open('user_manual.pdf');
            },
          ),
        ),
      ],
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.grey3,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
