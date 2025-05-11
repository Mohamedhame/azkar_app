import 'package:azkar_app/controller/sound_play_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/widget/bottom_sheet_customization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomShowSpeedAudioPage extends StatelessWidget {
  const CustomShowSpeedAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            "سرعة التشغيل",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<SoundPlayCtrl>(
                builder: (context, model, child) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: theme.primaryColor,
                        context: context,
                        builder: (context) {
                          return Selector<SoundPlayCtrl, double>(
                            builder: (context, value, child) {
                              return BottomSheetCustomization(
                                theme: theme,
                                value: value,
                                max: 2.05,
                                min: 0.45,
                                data: model.speedList,
                                pressAdd: model.increaseSpeed,
                                pressRemove: model.decreaseSpeed,
                                onChanged: model.setSpeed,
                                onPressedOnItem: (p0) {
                                  model.setSpeed(model.speedList[p0]);
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            selector: (p0, p1) => p1.speed,
                          );
                        },
                      );
                    },
                    child: Text(
                      model.speed.toStringAsFixed(2),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

