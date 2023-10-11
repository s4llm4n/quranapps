// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranapps/app/contants/color.dart';
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
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.search),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assalamualaikum',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 150,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    appPurpleLight2,
                    appPurpleDark,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // body: FutureBuilder<List<Surah>>(
      //     future: controller.getAllSurah(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       if (!snapshot.hasData) {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       return ListView.builder(
      //           itemCount: snapshot.data!.length,
      //           itemBuilder: (context, index) {
      //             Surah surah = snapshot.data![index];
      //             return ListTile(
      //               onTap: () {
      //                 Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
      //               },
      //               leading: CircleAvatar(
      //                 child: Text("${surah.number}"),
      //               ),
      //               title: Text("${surah.name?.transliteration?.id}"),
      //               subtitle: Text("${surah.numberOfVerses} Ayat | ${surah.revelation?.id}"),
      //               trailing: Text("${surah.name?.short}"),
      //             );
      //           });
      //     },
      //   ),
    );
  }
}
