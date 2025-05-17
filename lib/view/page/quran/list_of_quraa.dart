import 'package:azkar_app/controller/list_of_quraa_ctrl.dart';
import 'package:azkar_app/controller/sound_play_ctrl.dart';
import 'package:azkar_app/controller/surah_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/functions/opacity_to_alph.dart';
import 'package:azkar_app/view/page/quran/surah.dart';
import 'package:azkar_app/view/widget/custom_app_bar.dart';
import 'package:azkar_app/view/widget/custom_design_buuton.dart';
import 'package:azkar_app/view/widget/custom_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfQuraa extends StatelessWidget {
  const ListOfQuraa({super.key});

  final bool showIcon = true;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<ListOfQuraaCtrl>(context);
    final audioCrtl = Provider.of<SoundPlayCtrl>(context);
    List data = model.filterQuraaOnSearch;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: customAppBar(theme: theme, title: "قائمة القراء"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            CustomTextFormField(
              label: "ابحث عن اسم القارئ",
              onChanged: model.runFilterData,
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  data.isEmpty
                      ? Center(
                        child: Text(
                          "لا يوجد قراء بهذا الاسم.",
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.fontColor.withAlpha(
                              opacityToAlpha(0.7),
                            ),
                          ),
                        ),
                      )
                      : ListView.separated(
                        itemCount: data.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          String shikhName = data[index]['name'];
                          String url = data[index]['url'];

                          return CustomDesignBuuton(
                            titleItem: shikhName,
                            icon:
                                showIcon
                                    ? Icons.mic
                                    : null,
                          
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => ChangeNotifierProvider(
                                        create:
                                            (context) => SurahCtrl(
                                              shikhName: shikhName,
                                              url: url,
                                            )..goToAudio(context, audioCrtl),
                                        child: const Surah(),
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
