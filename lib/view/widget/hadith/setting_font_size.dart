import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/widget/bottom_sheet_customization.dart';
import 'package:azkar_app/view/widget/hadith/custom_text_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingFontSize extends StatelessWidget {
  const SettingFontSize({super.key, required this.theme});
  final ThemeController theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showBottomSheet(
            backgroundColor: theme.primaryColor,
            context: context,
            builder: (context) {
              return Selector<ThemeController, double>(
                builder: (context, value, child) {
                  return BottomSheetCustomization(
                    theme: theme,
                    value: value,
                    max: 70,
                    min: 12,
                    onChanged: theme.onChangedFontSize,
                    pressAdd: theme.increaseFontSize,
                    pressRemove: theme.decreaseFontSize,
                    widget: CustomTextSize(theme: theme),
                  );
                },
                selector: (p0, p1) => p1.fontSize,
              );
            },
          );
        },
        child: Icon(Icons.font_download),
      ),
    );
  }
}