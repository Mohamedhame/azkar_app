import 'package:azkar_app/controller/theme_controller.dart';
import 'package:flutter/material.dart';

class IndexPageOfHadithPage extends StatelessWidget {
  const IndexPageOfHadithPage({
    super.key,
    required this.theme,
    required this.index,
  });
  final ThemeController theme;
  final String index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.fontColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              index,
              style: TextStyle(color: theme.primaryColor, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
