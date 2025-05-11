import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/widget/audio/custom_icon.dart';
import 'package:flutter/material.dart';

class CustomIconCloseSheetBottom extends StatelessWidget {
  const CustomIconCloseSheetBottom({super.key, required this.theme});

  final ThemeController theme;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: CustomIcon(
        theme: theme,
        icon: Icons.close,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
