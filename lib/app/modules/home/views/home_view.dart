// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranapps/app/data/models/surah.dart';
import 'package:quranapps/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Quran'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Surah>>(
          future: controller.getAllSurah(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Surah surah = snapshot.data![index];
                  return ListTile(
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
                    },
                    leading: CircleAvatar(
                      child: Text("${surah.number}"),
                    ),
                    title: Text("${surah.name?.transliteration?.id}"),
                    subtitle: Text("${surah.numberOfVerses} Ayat | ${surah.revelation?.id}"),
                    trailing: Text("${surah.name?.short}"),
                  );
                });
          }),
    );
  }
}
