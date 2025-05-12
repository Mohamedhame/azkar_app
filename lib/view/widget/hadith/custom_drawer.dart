import 'package:azkar_app/controller/show_hadith_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/widget/hadith/custom_item_in_list_view_hadith.dart';
import 'package:flutter/material.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.theme, required this.model});
  final ThemeController theme;
  final ShowHadithCtrl model;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: theme.primaryColor,
      child: ListView.builder(
        itemCount: model.hadithBooks.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              model.jumpToPage(model.hadithBooks[index]['id'] - 1);
              Navigator.of(context).pop();
            },
            child: CustomItemInListViewHadith(
              theme: theme,
              titleOfBooks: model.hadithBooks[index]['title'],
              bookId: model.hadithBooks[index]['id'].toString(),
            ),
          );
        },
      ),
    );
  }
}
