import 'package:azkar_app/controller/settings_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/widget/bottom_sheet_customization.dart';
import 'package:azkar_app/view/widget/custom_app_bar.dart';
import 'package:azkar_app/view/widget/custom_design_buuton.dart';
import 'package:azkar_app/view/widget/mawaqit/custom_remember_raw.dart';
import 'package:azkar_app/view/widget/mawaqit/custom_text_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<SettingsCtrl>(context, listen: false);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: customAppBar(theme: theme, title: "حول التطبيق"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                textAlign: TextAlign.center,
                'بفضل الله، تم تطوير هذا التطبيق ليكون رفيقًا للمسلم في حياته اليومية، جامعًا بين الفائدة والسهولة إن شاء الله.',
                style: GoogleFonts.amiri(
                  fontSize: 18,
                  height: 1.6,
                  color: theme.fontColor,
                ),
              ),
            ),
            const Divider(),
            ...[
              {
                'icon': Icons.book,
                'title': 'القرآن الكريم',
                'subtitle': 'تلاوة صوتية وسماع مباشر من قراء مميزين',
              },
              {
                'icon': Icons.menu_book,
                'title': 'الحديث النبوي الشريف',
                'subtitle':
                    'صحيح الامام البخاري وصحيح الامام مسلم والابعين النوويه للإمام النووي رحمهم الله',
              },
              {
                'icon': Icons.access_time,
                'title': 'مواقيت الصلاة',
                'subtitle': 'بحسب الموقع الجغرافي للمستخدم',
              },

              {
                'icon': Icons.record_voice_over,
                'title': 'السيرة النبوية المطهرة',
                'subtitle': 'عرض صوتي لسيرة خير الأنام للدكتور راغب السرجاني',
              },
              {
                'icon': Icons.shield,
                'title': 'حصن المسلم',
                'subtitle': 'أذكار الصباح والمساء وأذكار متنوعة',
              },
              {
                'icon': Icons.brightness_low,
                'title': 'السبحة',
                'subtitle': 'لعلها تكون معينة لك علي ذكر الله',
              },
            ].map((item) {
              return Card(
                color: theme.primaryColor,
                elevation: 2,
                shadowColor: theme.fontColor,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(item['icon'] as IconData, color: Colors.teal),
                  title: Text(
                    item['title'] as String,
                    style: GoogleFonts.amiri(color: theme.fontColor),
                  ),
                  subtitle: Text(
                    item['subtitle'] as String,
                    style: GoogleFonts.amiri(color: theme.fontColor),
                  ),
                ),
              );
            }),
            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: theme.fontColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    "ايها الاخوة لا تنسوا إخوانكم في غزة وفي كل ارض الاسلام من الدعاء\nاللهم اعد المسجد الاقصى الي رحاب المسلمين ",
                    style: GoogleFonts.amiri(
                      fontSize: 16,
                      height: 1.6,
                      fontStyle: FontStyle.italic,
                      color: theme.fontColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: theme.fontColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'نسأل الله أن ينفع بهذا التطبيق كل من يستخدمه، وأن يجعله في ميزان حسناتنا جميعًا.\nولا تنسونا من صالح دعائكم 🌿',
                    style: GoogleFonts.amiri(
                      fontSize: 16,
                      height: 1.6,
                      fontStyle: FontStyle.italic,
                      color: theme.fontColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Selector<SettingsCtrl, String>(
              builder: (context, value, child) {
                return CustomDesignBuuton(
                  titleItem: "التذكير بالصلاة علي النبي",
                  widget: CustomTextInSettingPage(
                    theme: theme,
                    textButton: value,
                    onTap: () async {
                      bool isRun = await model.isRemeber();
                      if (isRun) {
                        model.stopRemember();
                      } else {
                        showModalBottomSheet(
                          backgroundColor: theme.primaryColor,
                          context: context,
                          builder: (context) {
                            return Selector<SettingsCtrl, double>(
                              builder: (context, value, child) {
                                return BottomSheetCustomization(
                                  theme: theme,
                                  value: value,
                                  max: 59,
                                  min: 14,
                                  pressAdd: model.increase5Minuts,
                                  pressRemove: model.decrease5Minuts,
                                  widget: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: CustomRemeberRow(
                                          theme: theme,
                                          value: value.toStringAsFixed(2),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: CustomTextInSettingPage(
                                          theme: theme,
                                          textButton: "تشغيل",
                                          onTap: () {
                                            model.playRemeber();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              selector: (p0, p1) => p1.valueOnSlider,
                            );
                          },
                        );
                      }
                    },
                  ),
                );
              },
              selector: (p0, p1) => p1.titleRemeber,
            ),
            CustomDesignBuuton(
              titleItem: "التذكير بمواقيت الصلاة",
              widget: Selector<SettingsCtrl, String>(
                builder: (context, value, child) {
                  return CustomTextInSettingPage(
                    theme: theme,
                    textButton: value,
                    onTap: () {
                      model.changePrayerState();
                    },
                  );
                },
                selector: (p0, p1) => p1.titlePrayer,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
