import 'package:azkar_app/service/shared.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CounterCtrl extends ChangeNotifier {
  CounterCtrl() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    zekr.text = azkarList[0];
    getAzkerFromShared();
  }

  TextEditingController zekr = TextEditingController();
  TextEditingController count = TextEditingController(text: "33");
  TextEditingController addZekr = TextEditingController();
  int counter = 0;
  double percent = 0.0;
  List azkerFromShared = [];

  List<String> azkarList = [
    "سبحان الله",
    "الحمد لله",
    "لا إله إلا الله",
    "الله أكبر",
    "لا حول ولا قوة إلا بالله",
    "سبحان الله وبحمده، سبحان الله العظيم",
    "اللهم صل وسلم على نبينا محمد",
    "أستغفر الله العظيم وأتوب إليه",
    "اللهم اغفر لي ولوالدي",
    "حسبي الله لا إله إلا هو عليه توكلت وهو رب العرش العظيم",
    "اللهم اجعلني من التوابين واجعلني من المتطهرين",
    "اللهم إنك عفو كريم تحب العفو فاعفُ عني",
    "رضيت بالله رباً، وبالإسلام ديناً، وبمحمد ﷺ نبياً",
    "اللهم ارزقني حسن الخاتمة",
    "يا حي يا قيوم برحمتك أستغيث، أصلح لي شأني كله",
  ];

  Future saveAzkarInShred() async {
    await Shared.saveAzkar(azkarList);
  }

  getAzkerFromShared() async {
    azkerFromShared = await Shared.getListOfZekr();
    notifyListeners();
  }

  insertIntoAzkerListInShared() async {
    if (addZekr.text.isNotEmpty && !azkerFromShared.contains(addZekr.text)) {
      azkerFromShared.add(addZekr.text);
      zekr.text = addZekr.text;
    }
  }

  deleteItemFromShared(int index) async {
    if (zekr.text == azkerFromShared[index]) {
      zekr.text = azkerFromShared[0];
      notifyListeners();
    }
    azkerFromShared.removeAt(index);
    await Shared.saveAzkar(azkerFromShared);
    await getAzkerFromShared();
  }

  setInZekrController(String z) {
    zekr.clear();
    zekr.text = z;
    notifyListeners();
  }

  counterFunc() {
    int countInTextField = int.parse(count.text);
    if (counter < countInTextField) {
      counter++;
      percent = counter / countInTextField;
      notifyListeners();
    } else {
      resetCounter();
    }
  }

  resetCounter() {
    counter = 0;
    percent = 0.0;
    notifyListeners();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    resetCounter();
    super.dispose();
  }
}
