// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranapps/app/data/models/surah.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SURAH ${surah.name.transliteration.id.toUpperCase()}'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailSurahView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}