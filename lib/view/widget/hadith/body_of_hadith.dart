import 'package:azkar_app/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyOfHadith extends StatelessWidget {
  const BodyOfHadith({super.key, required this.text, required this.theme});

  final ThemeController theme;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: GoogleFonts.amiri(
            color: theme.fontColor,
            fontSize: theme.fontSize,
            height: 2,
          ),
        ),
      ),
    );
  }
}
