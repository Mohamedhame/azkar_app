import 'package:azkar_app/controller/naway_explain_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/widget/custom_app_bar.dart';
import 'package:azkar_app/view/widget/hadith/body_of_hadith.dart';
import 'package:azkar_app/view/widget/hadith/custom_driver_and_text_static.dart';
import 'package:azkar_app/view/widget/hadith/title_of_hadith.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NawayHadithExplain extends StatelessWidget {
  const NawayHadithExplain({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<NawayExplainCtrl>(context);
    if (model.isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: customAppBar(theme: theme, title: model.chapterTitle),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: theme.fontColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //=================== title of Haith ================
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TitelOfHadith(
                      theme: theme,
                      title: model.chapterTitle,
                    ),
                  ),
                  //=================== Nuse Hadith ================
                  CustomDivder(theme: theme, text: "نص الحديث"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BodyOfHadith(theme: theme, text: model.body),
                  ),

                  //=================== Explain Hadith ================
                  CustomDivder(theme: theme, text: "شرح الحديث"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BodyOfHadith(theme: theme, text: model.explain),
                  ),
                  //=================== Rawy Hadith ================
                  CustomDivder(theme: theme, text: "راوي الحديث"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BodyOfHadith(theme: theme, text: model.rawy),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

