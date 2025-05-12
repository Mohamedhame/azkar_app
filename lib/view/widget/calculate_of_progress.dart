import 'package:azkar_app/controller/theme_controller.dart' show ThemeController;
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class CulculateOfProgress<T extends ChangeNotifier> extends StatelessWidget {
  const CulculateOfProgress({
    super.key,
    required this.theme,
    required this.centerText,
    required this.selector,
    required this.radius,
    this.fontSize,
  });

  final ThemeController theme;
  final String centerText;
  final double Function(T) selector;
  final double radius;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Selector<T, double>(
      selector: (context, notifier) => selector(notifier),
      builder: (context, value, child) {
        return CircularPercentIndicator(
          radius: radius,
          percent: value,
          center: Text(
            centerText,
            style: TextStyle(color: theme.fontColor, fontSize: fontSize),
          ),
        );
      },
    );
  }
}
