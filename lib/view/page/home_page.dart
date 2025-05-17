import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/utilities/routes.dart';
import 'package:azkar_app/view/widget/custom_change_theme.dart';
import 'package:azkar_app/view/widget/custom_design_buuton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomChangeTheme(theme: theme),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                children: [
                  CustomDesignBuuton(
                    titleItem: "القرآن الكريم",
                    onTap:
                        () => Navigator.of(context).pushNamed(AppRoutes.quran),
                    backgroundColor: theme.secondaryColor,
                    foregroundColor: theme.fontColor,
                    icon: Icons.menu_book_rounded,
                  ),
                  const SizedBox(height: 20),
                  CustomDesignBuuton(
                    titleItem: "السيرة النبوية",
                    onTap:
                        () => Navigator.of(context).pushNamed(AppRoutes.sira),
                    backgroundColor: theme.secondaryColor,
                    foregroundColor: theme.fontColor,
                    icon: Icons.history_edu_rounded,
                  ),
                  const SizedBox(height: 20),
                  CustomDesignBuuton(
                    titleItem: "الحديث النبوي الشريف",
                    onTap:
                        () => Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.listOfBooks),
                    backgroundColor: theme.secondaryColor,
                    foregroundColor: theme.fontColor,
                    icon: Icons.library_books_rounded,
                  ),
                  const SizedBox(height: 20),
                  CustomDesignBuuton(
                    titleItem: "حصن المسلم",
                    onTap:
                        () => Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.showAzkar),
                    backgroundColor: theme.secondaryColor,
                    foregroundColor: theme.fontColor,
                    icon: Icons.shield_moon_rounded,
                  ),
                  const SizedBox(height: 20),
                  CustomDesignBuuton(
                    titleItem: "السبحة",
                    onTap:
                        () =>
                            Navigator.of(context).pushNamed(AppRoutes.counter),
                    backgroundColor: theme.secondaryColor,
                    foregroundColor: theme.fontColor,
                    icon: Icons.format_list_numbered_rounded,
                  ),
                  const SizedBox(height: 20),
                  CustomDesignBuuton(
                    titleItem: "مواقيت الصلاة",
                    onTap:
                        () =>
                            Navigator.of(context).pushNamed(AppRoutes.mawaqit),
                    backgroundColor: theme.secondaryColor,
                    foregroundColor: theme.fontColor,
                    widget: SvgPicture.asset(
                      "assets/images/mawaqit.svg",
                      width: 30,
                      height: 30,
                      colorFilter: ColorFilter.mode(
                        theme.fontColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomDesignBuuton(
                    titleItem: "حول التطبيق",
                    onTap:
                        () =>
                            Navigator.of(context).pushNamed(AppRoutes.settings),
                    backgroundColor: theme.secondaryColor,
                    foregroundColor: theme.fontColor,
                    icon: Icons.info_outline,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
