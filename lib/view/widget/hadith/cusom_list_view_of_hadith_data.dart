import 'package:azkar_app/controller/naway_explain_ctrl.dart';
import 'package:azkar_app/controller/show_hadith_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/page/hadith/naway_hadith_explain.dart';
import 'package:azkar_app/view/widget/hadith/body_of_hadith.dart';
import 'package:azkar_app/view/widget/hadith/title_of_hadith.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CusomListViewOfHadithData extends StatelessWidget {
  const CusomListViewOfHadithData({
    super.key,
    required this.model,
    required this.theme,
  });

  final ShowHadithCtrl model;
  final ThemeController theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Selector<ShowHadithCtrl, bool>(
        builder: (context, value, child) {
          if (value) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: model.hadith.length,
            itemBuilder: (context, idx) {
              String titelOfHadith =
                  model.hadith[idx]['chapterTitle'] != ""
                      ? model.hadith[idx]['chapterTitle']
                      : "باب";
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap:
                      model.isNaway
                          ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChangeNotifierProvider(
                                    create:
                                        (context) => NawayExplainCtrl(
                                          title:
                                              model.hadith[idx]['chapterTitle'],
                                        ),
                                    child: NawayHadithExplain(),
                                  );
                                },
                              ),
                            );
                          }
                          : null,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 0.5, color: theme.fontColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          //==== titel of hadith =========
                          TitelOfHadith(theme: theme, title: titelOfHadith),
                          //====== Nuse of hadith ===============
                          BodyOfHadith(
                            theme: theme,
                            text: model.hadith[idx]['body'],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        selector: (p0, p1) => p1.textLoading,
      ),
    );
  }
}
