import 'package:azkar_app/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomItemInListViewHadith extends StatelessWidget {
  const CustomItemInListViewHadith({
    super.key,
    required this.theme,
    required this.titleOfBooks,
    required this.bookId,
  });
  final ThemeController theme;
  final String titleOfBooks;
  final String bookId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: theme.fontColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  titleOfBooks,
                  style: GoogleFonts.amiri(
                    color: theme.fontColor,
                    fontSize: 18,
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.fontColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    bookId,
                    style: TextStyle(color: theme.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
