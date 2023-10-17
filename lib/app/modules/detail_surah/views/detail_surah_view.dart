// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranapps/app/contants/color.dart';
import 'package:quranapps/app/data/models/detail_surah.dart' as detail;
import 'package:quranapps/app/data/models/surah.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'SURAH ${surah.name?.transliteration?.id?.toUpperCase() ?? 'Error...'}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () => Get.dialog(
              Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Get.isDarkMode
                        ? appPurpleLight2.withOpacity(0.3)
                        : appWhite,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Tafsir ${surah.name?.transliteration?.id}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${surah.tafsir?.id ?? 'Data tafsir tidak ada.'}",
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  appPurpleLight1,
                  appPurpleDark,
                ]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      surah.name?.transliteration?.id?.toUpperCase() ??
                          'Error..',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: appWhite,
                      ),
                    ),
                    Text(
                      '( ${surah.name?.translation?.id?.toUpperCase() ?? 'Error..'} )',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: appWhite,
                      ),
                    ),
                    Text(
                      '${surah.numberOfVerses ?? 'Error..'} Ayat | ${surah.revelation?.id}',
                      style: TextStyle(
                        fontSize: 16,
                        color: appWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FutureBuilder<detail.DetailSurah>(
            future: controller.getDetailSurah(surah.number.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text("Tidak ada data."),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.verses?.length ?? 0,
                itemBuilder: (context, index) {
                  if (snapshot.data?.verses?.length == 0) {
                    return SizedBox();
                  }
                  detail.Verse? ayat = snapshot.data?.verses?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: appPurpleLight2.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(Get.isDarkMode
                                        ? "assets/images/list_dark.png"
                                        : "assets/images/list_light.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: Center(
                                  child: Text("${index + 1}"),
                                ),
                              ),
                              GetBuilder<DetailSurahController>(
                                builder: (c) => Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.bookmark_add_outlined),
                                    ),
                                    // Kondisi => Stop => button play
                                    // Kondisi => playing => button pause & button stop
                                    //kondisi => pause => button resume & button stop
                                    (ayat?.kondisiAudio == "stop")
                                        ? IconButton(
                                            onPressed: () {
                                              c.playAudio(ayat);
                                            },
                                            icon: Icon(Icons.play_arrow),
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              (ayat?.kondisiAudio == "playing")
                                                  ? IconButton(
                                                      onPressed: () {
                                                        c.pauseAudio(ayat!);
                                                      },
                                                      icon: Icon(Icons.pause),
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        c.resumeAudio(ayat!);
                                                      },
                                                      icon: Icon(
                                                          Icons.play_arrow),
                                                    ),
                                              IconButton(
                                                onPressed: () {
                                                  c.stopAudio(ayat!);
                                                },
                                                icon: Icon(Icons.stop),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${ayat!.text?.arab}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${ayat.text?.transliteration?.en}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${ayat.translation?.id}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
