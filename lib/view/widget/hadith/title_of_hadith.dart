import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/functions/opacity_to_alph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitelOfHadith extends StatelessWidget {
  const TitelOfHadith({
    super.key,
    required this.theme,
    required this.title,
  });

  final ThemeController theme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.fontColor.withAlpha(opacityToAlpha(0.2)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: GoogleFonts.amiri(
              color: theme.fontColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
