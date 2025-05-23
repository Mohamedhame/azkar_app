import 'package:azkar_app/controller/sira_ctrl.dart';
import 'package:azkar_app/controller/sound_play_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/page/sound_play.dart';
import 'package:azkar_app/view/widget/custom_app_bar.dart';
import 'package:azkar_app/view/widget/custom_design_buuton.dart';
import 'package:azkar_app/view/widget/quran_and_sira/custom_download_or_check_icon_and_paly_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sira extends StatelessWidget {
  const Sira({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final soundPlay = Provider.of<SoundPlayCtrl>(context);
    return ChangeNotifierProvider(
      create: (context) => SiraCtrl()..goToAudio(context, soundPlay),
      child: Consumer<SiraCtrl>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: theme.primaryColor,
            appBar: customAppBar(theme: theme, title: "السيره النبوية"),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child:
                  model.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        itemCount: model.siraData.length,
                        itemBuilder: (context, index) {
                          return CustomDesignBuuton(
                            titleItem: model.siraData[index]['name'],
                            widget: CustomDownloadOrCheckIconAndPalyIcon(
                              theme: theme,
                              data: model.siraData,
                              index: index,
                              dir: "الدكتور راغب السرجاني",
                            ),

                            onTap: () {
                              soundPlay.playAudio(
                                model.siraData,
                                index,
                                shikhName: "الدكتور راغب السرجاني",
                              );
                              soundPlay.handlePlayPause();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => SoundPlay(
                                        sikhName: "الدكتور راغب السرجاني",
                                        isSerah: true,
                                        data: model.siraData,
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
        },
      ),
    );
  }
}
