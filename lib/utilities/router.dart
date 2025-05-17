import 'package:azkar_app/controller/list_of_quraa_ctrl.dart';
import 'package:azkar_app/utilities/routes.dart';
import 'package:azkar_app/view/page/counter.dart';
import 'package:azkar_app/view/page/hadith/list_of_books.dart';
import 'package:azkar_app/view/page/hadith/show_azkar.dart';
import 'package:azkar_app/view/page/home_page.dart';
import 'package:azkar_app/view/page/mawaqit/mawaqit.dart';
import 'package:azkar_app/view/page/quran/list_of_quraa.dart';
import 'package:azkar_app/view/page/quran/quran.dart';
import 'package:azkar_app/view/page/quran/read_quran.dart';
import 'package:azkar_app/view/page/settings.dart';
import 'package:azkar_app/view/page/sira.dart';
import 'package:azkar_app/view/page/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.quran:
      return CupertinoPageRoute(
        builder: (_) => const Quran(),
        settings: settings,
      );
    case AppRoutes.readQuran:
      return CupertinoPageRoute(
        builder: (_) => const ReadQuran(),
        settings: settings,
      );
    case AppRoutes.listOfQurra:
      return CupertinoPageRoute(
        builder:
            (_) => ChangeNotifierProvider(
              create: (context) => ListOfQuraaCtrl(),
              child: ListOfQuraa(),
            ),
        settings: settings,
      );
    case AppRoutes.sira:
      return CupertinoPageRoute(builder: (_) => Sira(), settings: settings);

    case AppRoutes.listOfBooks:
      return CupertinoPageRoute(
        builder: (_) => ListOfBooks(),
        settings: settings,
      );
    case AppRoutes.showAzkar:
      return CupertinoPageRoute(
        builder: (_) => ShowAzkar(),
        settings: settings,
      );

    case AppRoutes.counter:
      return CupertinoPageRoute(builder: (_) => Counter(), settings: settings);

    case AppRoutes.mawaqit:
      return CupertinoPageRoute(
        builder: (_) => const Mawaqit(),
        settings: settings,
      );
    case AppRoutes.settings:
      return CupertinoPageRoute(
        builder: (_) => const Settings(),
        settings: settings,
      );
    case AppRoutes.homePage:
      return CupertinoPageRoute(builder: (_) => HomePage(), settings: settings);
    default:
      return CupertinoPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
  }
}
