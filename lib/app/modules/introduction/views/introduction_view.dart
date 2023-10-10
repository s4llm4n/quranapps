import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quranapps/app/contants/color.dart';
import 'package:quranapps/app/routes/app_pages.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Al-Qurran Apps',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: appPurple,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Text(
                'Sesibuk itukah kamu sampai lupa membaca Al-Quran',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
             const SizedBox(height: 10),
            Container(
              width: 250,
              height: 250,
              child: Lottie.asset(
                "assets/lotties/animasi-quran.json",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.HOME),
              child: const Text('Mulai'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF431AA1)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
