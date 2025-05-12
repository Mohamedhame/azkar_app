import 'package:azkar_app/controller/show_hadith_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/page/hadith/index_page_of_hadith_page.dart';
import 'package:azkar_app/view/widget/custom_app_bar.dart';
import 'package:azkar_app/view/widget/custom_button.dart';
import 'package:azkar_app/view/widget/hadith/cusom_list_view_of_hadith_data.dart';
import 'package:azkar_app/view/widget/hadith/custom_drawer.dart';
import 'package:azkar_app/view/widget/hadith/setting_font_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowHadith extends StatelessWidget {
  const ShowHadith({super.key, required this.titleOfBook});
  final String titleOfBook;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<ShowHadithCtrl>(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      drawer: model.isNaway ? null : CustomDrawer(theme: theme, model: model),
      appBar: customAppBar(
        theme: theme,
        title: titleOfBook,
        widget: SettingFontSize(theme: theme),
      ),
      body: Selector<ShowHadithCtrl, bool>(
        builder: (context, value, child) {
          if (model.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return PageView.builder(
            itemCount: model.isNaway ? 1 : model.hadithBooks.length,
            controller: model.pageController,
            onPageChanged: (value) {
              model.changeCurrentIndex(value + 1);
              model.loadHadith();
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: theme.fontColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // title of
                      if (!model.isNaway)
                        CustomButton(
                          textButton: model.hadithBooks[index]['title'],
                          backgroundColor: theme.fontColor,
                          foregroundColor: theme.primaryColor,
                        ),
                      CusomListViewOfHadithData(model: model, theme: theme),
                      if (!model.isNaway)
                        IndexPageOfHadithPage(
                          theme: theme,
                          index: model.currentIndex.toString(),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        selector: (p0, p1) => p1.isLoading,
      ),
    );
  }
}