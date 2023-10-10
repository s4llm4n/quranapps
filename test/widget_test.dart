import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quranapps/app/data/models/ayat.dart';

void main() async {
  // ignore: unused_local_variable
  var res = await http.get(Uri.parse("https://api.quran.gading.dev/surah/108/2"));
  Map<String, dynamic> data = json.decode(res.body)["data"];
  Map<String, dynamic> dataToModel = {
    "number": data["number"],
    "meta": data["meta"],
    "text": data["text"],
    "translation": data["translation"],
    // "audio": data["audio"],
    "tafsir": data["tafsir"],
  };

  // convert Map -> Model Ayat
  Ayat ayat = Ayat.fromJson(dataToModel);

  print(ayat.tafsir?.id?.short);
}