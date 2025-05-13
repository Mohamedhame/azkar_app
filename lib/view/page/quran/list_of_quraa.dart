import 'package:azkar_app/controller/list_of_quraa_ctrl.dart';
import 'package:azkar_app/controller/sound_play_ctrl.dart';
import 'package:azkar_app/controller/surah_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/page/quran/surah.dart';
import 'package:azkar_app/view/widget/custom_app_bar.dart';
import 'package:azkar_app/view/widget/custom_design_buuton.dart';
import 'package:azkar_app/view/widget/custom_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfQuraa extends StatelessWidget {
  const ListOfQuraa({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<ListOfQuraaCtrl>(context);
    final audioCrtl = Provider.of<SoundPlayCtrl>(context);
    List data = model.filterQuraaOnSearch;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: customAppBar(theme: theme, title: "قائمة القراء"),
      body: Column(
        children: [
          CustomTextFormField(
            label: "اسم القارئ",
            onChanged: model.runFilterData,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                String shikhName = data[index]['name'];
                String url = data[index]['url'];
                return CustomDesignBuuton(
                  titleItem: shikhName,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => ChangeNotifierProvider(
                              create:
                                  (context) =>
                                      SurahCtrl(shikhName: shikhName, url: url)
                                        ..goToAudio(context, audioCrtl),
                              child: Surah(),
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
    );
  }
}
