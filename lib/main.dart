import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranapps/app/contants/color.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeLight,
      title: "Application",
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
    ),
  );
}
