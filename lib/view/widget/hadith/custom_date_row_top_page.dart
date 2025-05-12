import 'package:azkar_app/controller/show_zekr_based_on_indexing_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/widget/hadith/custom_date_widget.dart';
import 'package:flutter/material.dart';

class CustomDataRowTopPage extends StatelessWidget {
  const CustomDataRowTopPage({
    super.key,
    required this.size,
    required this.theme,
    required this.model,
  });

  final Size size;
  final ThemeController theme;
  final ShowZekrBasedOnIndexingCtrl model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.25,
            child: CustomDateWidget(theme: theme, textDate: model.date ?? ""),
          ),
          SizedBox(
            width: size.width * 0.25,
            child: CustomDateWidget(
              theme: theme,
              textDate: model.weekday[model.currentWeekday ?? 1],
            ),
          ),
          SizedBox(
            width: size.width * 0.25,
            child: CustomDateWidget(theme: theme, textDate: "${model.format}"),
          ),
        ],
      ),
    );
  }
}
