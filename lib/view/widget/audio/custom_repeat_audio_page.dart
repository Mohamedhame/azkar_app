import 'package:azkar_app/controller/sound_play_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomRepeatAudioPage extends StatelessWidget {
  const CustomRepeatAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SoundPlayCtrl>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Selector<SoundPlayCtrl, bool>(
          builder: (context, value, child) {
            return InkWell(
              onTap: model.changeRepeat,
              child: Icon(
                value ? Icons.repeat_one : Icons.repeat,
                size: 32,
                color: Colors.white,
              ),
            );
          },
          selector: (p0, p1) => p1.isRepeat,
        ),
      ),
    );
  }
}
