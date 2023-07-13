import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quranapps/app/data/models/detail_surah.dart';
import 'package:quranapps/app/data/models/surah.dart';

void main() async {
  Uri url = Uri.parse("https://api.quran.gading.dev/surah");
  var res = await http.get(url);

  List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

  // print(data[113]["number"]);

  // data dari api  (raw data) -> Model (yang sudah disiapin)
  Surah surahAnnas = Surah.fromJson(data[113]);

  // print(surahAnnas.name);
  // print('===========');
  // print(surahAnnas.number);
  // print('===========');
  // print(surahAnnas.numberOfVerses);
  // print('===========');
  // print(surahAnnas.revelation);
  // print('===========');
  // print(surahAnnas.sequence);
  // print('===========');
  // print(surahAnnas.tafsir);

  // INI COBA MASUKK KE NESTED MODEL
  // print(surahAnnas.name.long);

  Uri urlAnnas =
      Uri.parse("https://api.quran.gading.dev/surah/${surahAnnas.number}");
  var resAnnas = await http.get(urlAnnas);

  Map<String, dynamic> dataAnnas =
      (json.decode(resAnnas.body) as Map<String, dynamic>)["data"];

  // data dari api  (raw data) -> Model (yang sudah disiapin)
  DetailSurah annas = DetailSurah.fromJson(dataAnnas);

  print(annas);
}
