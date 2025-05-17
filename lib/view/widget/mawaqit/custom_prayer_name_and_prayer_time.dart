import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPrayerNameAndTime extends StatelessWidget {
  const CustomPrayerNameAndTime({
    super.key,
    required this.prayrName,
    required this.prayerTime,
  });
  final String prayrName;
  final String prayerTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            prayrName,
            style: GoogleFonts.amiri(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            prayerTime,
            style: GoogleFonts.amiri(color: Colors.white, fontSize: 24),
          ),
        ],
      ),
    );
  }
}