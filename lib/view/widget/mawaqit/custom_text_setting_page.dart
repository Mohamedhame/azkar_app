import 'package:azkar_app/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextInSettingPage extends StatelessWidget {
  const CustomTextInSettingPage({
    super.key,
    required this.theme,
    required this.textButton,
    this.onTap,
  });
  final String textButton;

  final ThemeController theme;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.fontColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textButton,
            style: GoogleFonts.amiri(color: theme.primaryColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}