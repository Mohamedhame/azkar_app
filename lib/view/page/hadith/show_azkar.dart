import 'package:azkar_app/controller/show_index_of_azkar_ctrl.dart';
import 'package:azkar_app/controller/show_zekr_based_on_indexing_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/page/hadith/show_zekr_based_on_indexing.dart';
import 'package:azkar_app/view/widget/custom_app_bar.dart';
import 'package:azkar_app/view/widget/custom_design_buuton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowAzkar extends StatelessWidget {
  const ShowAzkar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    return ChangeNotifierProvider(
      create: (context) => ShowIndexOfAzkarCtrl(),
      child: Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: customAppBar(theme: theme, title: "حصن المسلم"),
        body: Consumer<ShowIndexOfAzkarCtrl>(
          builder: (context, model, child) {
            if (model.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: model.titleOfAzkar.length,
              itemBuilder: (context, index) {
                String title = model.titleOfAzkar[index]['category'];
                return CustomDesignBuuton(
                  titleItem: title,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => ChangeNotifierProvider(
                              create:
                                  (context) =>
                                      ShowZekrBasedOnIndexingCtrl(index: index),
                              child: ShowZekrBasedOnIndexing(),
                            ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
