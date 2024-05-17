import 'package:flutter/material.dart';
import 'package:update_flutter_project_one/configuration/app_colors.dart';

class CustomAdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAdminAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      toolbarHeight: 75,
      backgroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}
