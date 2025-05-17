import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> copyHadithJsonToFile() async {
  final String jsonString = await rootBundle.loadString('assets/data/nawawy/hadiths.json');
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/hadiths.json');
  await file.writeAsString(jsonString);
}