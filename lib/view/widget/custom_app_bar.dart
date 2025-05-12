  import 'package:azkar_app/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar customAppBar({
  required ThemeController theme,
  required String title,
  Widget? widget,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    foregroundColor: theme.fontColor,
    title: Text(
      title,
      style: GoogleFonts.amiri(
        color: theme.fontColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    actions: [if (widget != null) widget],
  );
}
