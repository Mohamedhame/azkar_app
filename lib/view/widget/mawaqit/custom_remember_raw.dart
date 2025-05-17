import 'package:azkar_app/controller/theme_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRemeberRow extends StatelessWidget {
  const CustomRemeberRow({super.key, required this.theme, required this.value});

  final ThemeController theme;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "تذكير كل",
          style: GoogleFonts.amiri(color: theme.fontColor, fontSize: 18),
        ),
        const SizedBox(width: 20),
        Text(value, style: TextStyle(color: theme.fontColor)),
        const SizedBox(width: 20),
        Text(
          "دقيقة",
          style: GoogleFonts.amiri(color: theme.fontColor, fontSize: 18),
        ),
      ],
    );
  }
}