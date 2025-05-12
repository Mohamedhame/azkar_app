import 'package:azkar_app/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDateWidget extends StatelessWidget {
  const CustomDateWidget({
    super.key,
    required this.theme,
    required this.textDate,
  });

  final ThemeController theme;
  final String textDate;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.fontColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          textAlign: TextAlign.center,
          textDate,
          style: GoogleFonts.amiri(color: theme.primaryColor),
        ),
      ),
    );
  }
}
