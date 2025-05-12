import 'package:azkar_app/controller/counter_ctrl.dart';
import 'package:azkar_app/controller/sound_play_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/functions/start_program.dart';
import 'package:azkar_app/utilities/router.dart';
import 'package:azkar_app/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await startProgram();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => SoundPlayCtrl()),
        ChangeNotifierProvider(create: (_) => CounterCtrl()),
      ],
      child: MaterialApp(
        title: 'Azkar App',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: Locale('ar'),
        supportedLocales: [Locale('ar'), Locale('en')],
        onGenerateRoute: onGenerateRoute,
        initialRoute: AppRoutes.homePage,
      ),
    );
  }
}
