import 'package:azkar_app/controller/show_zekr_based_on_indexing_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/functions/opacity_to_alph.dart';
import 'package:azkar_app/view/widget/calculate_of_progress.dart';
import 'package:azkar_app/view/widget/custom_app_bar.dart';
import 'package:azkar_app/view/widget/hadith/body_of_hadith.dart';
import 'package:azkar_app/view/widget/hadith/custom_date_row_top_page.dart';
import 'package:azkar_app/view/widget/hadith/setting_font_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowZekrBasedOnIndexing extends StatelessWidget {
  const ShowZekrBasedOnIndexing({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<ShowZekrBasedOnIndexingCtrl>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: customAppBar(
        theme: theme,
        title: model.title ?? "",
        widget: SettingFontSize(theme: theme),
      ),

      body: Column(
        children: [
          CustomDataRowTopPage(size: size, theme: theme, model: model),
          Expanded(
            child: ListView.builder(
              itemCount: model.data.length,
              itemBuilder: (context, index) {
                String text = model.data[index]['text'];
                int count = model.data[index]['count'];
                return SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.fontColor, width: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              model.incresePercent(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Selector<ThemeController, double>(
                                      builder: (context, value, child) {
                                        return BodyOfHadith(
                                          theme: theme,
                                          text: text,
                                        );
                                      },
                                      selector: (p0, p1) => p1.fontSize,
                                    ),
                                  ),
                                  //==================
                                  // Calculator Of Progress
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: theme.fontColor.withAlpha(
                                          opacityToAlpha(0.5),
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          textDirection: TextDirection.rtl,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CulculateOfProgress(
                                              theme: theme,
                                              radius: 20,
                                              centerText:
                                                  model.press[index].toString(),
                                              selector:
                                                  (
                                                    ShowZekrBasedOnIndexingCtrl
                                                    ctrl,
                                                  ) => ctrl.perecent[index],
                                            ),

                                            Text(
                                              count.toString(),
                                              style: TextStyle(
                                                color: theme.primaryColor,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
