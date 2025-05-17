import 'package:azkar_app/controller/sound_play_ctrl.dart';
import 'package:azkar_app/controller/surah_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/page/sound_play.dart';
import 'package:azkar_app/view/widget/custom_app_bar.dart';
import 'package:azkar_app/view/widget/custom_design_buuton.dart';
import 'package:azkar_app/view/widget/quran_and_sira/custom_download_or_check_icon_and_paly_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Surah extends StatelessWidget {
  const Surah({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<SurahCtrl>(context);
    final soundPlay = Provider.of<SoundPlayCtrl>(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: customAppBar(theme: theme, title: model.shikhName),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child:
            model.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                  itemCount: model.surahs.length,
                  itemBuilder: (context, index) {
                    return CustomDesignBuuton(
                      titleItem: model.surahs[index]['name'] ?? '',
                      widget: CustomDownloadOrCheckIconAndPalyIcon(
                        theme: theme,
                        data: model.surahs,
                        index: index,
                        dir: model.shikhName,
                      ),
                      onTap: () async {
                        soundPlay.playAudio(
                          model.surahs,
                          index,
                          shikhName: model.shikhName,
                        );
                        soundPlay.handlePlayPause();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => SoundPlay(
                                  sikhName: model.shikhName,
                                  isSerah: false,
                                  data: model.surahs,
                                  index: index,
                                ),
                          ),
                        );
                      },
                    );
                  },
                ),
      ),
    );
  }
}
