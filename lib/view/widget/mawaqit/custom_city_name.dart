import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCityName extends StatelessWidget {
  const CustomCityName({super.key, required this.cityName});
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Text(
      cityName,
      style: GoogleFonts.amiri(
        color: Colors.black,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
