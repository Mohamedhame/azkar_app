import 'package:azkar_app/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDivder extends StatelessWidget {
  const CustomDivder({super.key, required this.theme, required this.text});

  final ThemeController theme;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        CustomTextStatic(theme: theme, text: text),
        const SizedBox(height: 10),
      ],
    );
  }
}

class CustomTextStatic extends StatelessWidget {
  const CustomTextStatic({super.key, required this.theme, required this.text});

  final ThemeController theme;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(width: 0.4, color: theme.fontColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          child: Text(
            text,
            style: GoogleFonts.amiri(color: theme.fontColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
