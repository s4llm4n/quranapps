import 'dart:convert';

import 'package:get_cli/commands/impl/commads_export.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quranapps/app/data/models/detail_surah.dart';

class DetailSurahController extends GetxController {
  
  final player = AudioPlayer();

  Verse? lastverse;

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    return DetailSurah.fromJson(data);
  }

  void stopAudio(Verse ayat) async {
      try {
        await player.stop();
        ayat.kondisiAudio = "stop";
        update();
        
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString(),
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}",
        );
      } catch (e) {
        Get. defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat stop audio",
        );
      }
    }

  void resumeAudio(Verse ayat) async {
      try {
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        update();

      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString(),
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}",
        );
      } catch (e) {
        Get. defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat resume audio",
        );
      }
    }

  void pauseAudio(Verse ayat) async {
    try {
        await player.pause(); 
        ayat.kondisiAudio = "pause";
        update();
        //
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString(),
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}",
        );
      } catch (e) {
        Get. defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat puase audio",
        );
      }
  }


  void playAudio(Verse? ayat) async {
    if (ayat?.audio?.primary !=null) {
      try {
        // mencegah terjadinya penumpukan yang sedang berjalan
        if (lastverse == null) {
          lastverse = ayat;
        }
        lastverse!.kondisiAudio = "stop";
        lastverse = ayat;
        lastverse!.kondisiAudio = "stop";
        update();
        await player.stop(); // menjadi tercegahnya penumpukan audio yang sedang berjalan
        await player.setUrl(ayat!.audio!.primary!);
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        await player.stop();
        update();
        //
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString(),
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}",
        );
      } catch (e) {
        Get. defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat memutar audio",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "URL Audio tidak ada / tidak dapat diakses.",
      );
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
