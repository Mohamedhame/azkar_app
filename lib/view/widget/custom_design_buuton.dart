import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/functions/opacity_to_alph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomDesignBuuton extends StatelessWidget {
  const CustomDesignBuuton({
    super.key,
    required this.titleItem,
    this.onTap,
    this.fontSize = 18.0,
    this.fontWeight = FontWeight.w600,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.widget,
  });

  final String titleItem;
  final void Function()? onTap;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData? icon;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? theme.secondaryColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.fontColor.withAlpha(opacityToAlpha(0.2)),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(opacityToAlpha(0.05)),
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// النص
              Expanded(
                child: Text(
                  textAlign:
                      (icon == null && widget == null)
                          ? TextAlign.center
                          : null,
                  titleItem,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.amiri(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: foregroundColor ?? theme.fontColor,
                  ),
                ),
              ),

              /// مسافة صغيرة بين النص والأيقونة/الويدجت
              const SizedBox(width: 12),

              /// أيقونة (اختيارية)
              if (icon != null)
                Icon(icon, color: foregroundColor ?? theme.fontColor),

              /// ويدجت إضافية (اختيارية)
              if (widget != null) widget!,
            ],
          ),
        ),
      ),
    );
  }
}
