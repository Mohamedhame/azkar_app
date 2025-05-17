import 'package:azkar_app/functions/opacity_to_alph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRowRemaining extends StatelessWidget {
  const CustomRowRemaining({
    super.key,
    required this.title,
    required this.remaining,
  });
  final String title;
  final String remaining;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.transparent.withAlpha(opacityToAlpha(0.2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.amiri(color: Colors.white, fontSize: 22),
              ),
              Text(
                remaining,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
