import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/utilities/routes.dart';
import 'package:azkar_app/view/widget/custom_design_buuton.dart';
import 'package:azkar_app/view/widget/stylish_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Quran extends StatelessWidget {
  const Quran({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    // final media = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            children: [
              // المساحة العلوية
              Text(
                "القرآن الكريم",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: theme.fontColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Amiri",
                ),
              ),
              const SizedBox(height: 12),

              // محتوى قابل للتمرير
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // الكارت
                      const StylishCard(
                        title:
                            'عن أبي أُمَامَةَ البَاهِلِي رضي الله عنه قال: سمعتُ رسولَ اللهِ صلَّى اللهُ عليهِ وسلَّمَ يقول:',
                        body:
                            '"اقْرَؤُوا القُرآنَ، فإنَّهُ يأتي يومَ القيامةِ شفيعًا لأصحابِه"... رواه مسلم.',
                        footer: 'فإن غلبتَ على قراءته، فلا تُغلب على سماعه.',
                      ),
                      const SizedBox(height: 24),

                      // زر "تلاوة"
                      CustomDesignBuuton(
                        titleItem: "تلاوة",
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.readQuran);
                        },
                        icon: Icons.menu_book_rounded,
                      ),
                      const SizedBox(height: 12),

                      // زر "سماع"
                      CustomDesignBuuton(
                        titleItem: "سماع",
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.listOfQurra);
                        },
                        icon: Icons.headphones_rounded,
                      ),

                      const SizedBox(height: 20),
                    ],
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
