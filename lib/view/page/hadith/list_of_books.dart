import 'package:azkar_app/controller/show_hadith_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/page/hadith/show_hadith.dart';
import 'package:azkar_app/view/widget/custom_button.dart';
import 'package:azkar_app/view/widget/stylish_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfBooks extends StatelessWidget {
  const ListOfBooks({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 70),
            const StylishCard(
              title:
                  'عن زيد بن ثابت قال: سمعت رسول الله صلى الله عليه وسلم يقول:',
              body:
                  '" نضر الله امرأً سمع منا حديثا فحفظه حتى يبلغه غيره، فرب حامل فقه إلى من هو أفقه منه، ورب حامل فقه ليس بفقيه."..قال الترمذي: حديث حسن.',
              footer:
                  'العلم يرفع بيتاً لا عماد له، والجهل يهدم بيت العز والشرف',
            ),

            CustomButton(
              textButton: "صحيح البخاري",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => ChangeNotifierProvider(
                          create:
                              (context) => ShowHadithCtrl(bookName: "bukhari"),
                          child: ShowHadith(titleOfBook: "صحيح البخاري"),
                        ),
                  ),
                );
              },
            ),
            CustomButton(
              textButton: "صحيح مسلم",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => ChangeNotifierProvider(
                          create:
                              (context) => ShowHadithCtrl(bookName: "muslim"),
                          child: ShowHadith(titleOfBook: "صحيح مسلم"),
                        ),
                  ),
                );
              },
            ),

            CustomButton(
              textButton: "الاربعين النووية",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => ChangeNotifierProvider(
                          create:
                              (context) => ShowHadithCtrl(bookName: "nawawy"),
                          child: ShowHadith(titleOfBook: "الاربعين النووية"),
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
