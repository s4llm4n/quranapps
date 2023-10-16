import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quranapps/app/contants/color.dart';
import 'package:quranapps/app/data/models/juz.dart';
import 'package:quranapps/app/data/models/surah.dart';

class HomeController extends GetxController {
  RxBool isDark = false.obs;

  void changeThemeMode() async {
    Get.isDarkMode ? Get.changeTheme(themeLight) : Get.changeTheme(themeDark);
    isDark.toggle();

    final box = GetStorage();

    if (Get.isDarkMode) {
      // dark -> light
      box.remove("themeDark");
    } else {
      // light -> dark
      box.write("themeDark", true);
    }
  }

  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah");
    var res = await http.get(url);

    List? data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }

  Future<List<Juz>> getAllJuz() async {
    List<Juz> allJuz = [];
    for (int i = 1; i <= 30; i++) {
        Uri url = Uri.parse("https://api.quran.gading.dev/juz/30");
        var res = await http.get(url);

    Map<String, dynamic> data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    Juz juz = Juz.fromJson(data);
    allJuz.add(juz);
  }

  return allJuz;

  }
}
