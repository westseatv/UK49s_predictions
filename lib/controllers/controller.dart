import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'local_db.dart';

class AppController extends GetxController {
  LocalDb localDb = Get.put(LocalDb());
  List<int> generated = [];
  List<Color> colors = [];
  List<int> saved = [];

  void generate() {
    saved = [];
    int radNum;
    for (var i = 0; i < 7; i++) {
      radNum = Random(Timeline.now).nextInt(49) + 1;
      while (generated.contains(radNum)) {
        radNum = Random(Timeline.now).nextInt(49) + 1;
      }
      generated[i] = radNum;
    }
    colors.assignAll(
      List.generate(
        7,
        (i) {
          int r = Random(Timeline.now * (i + 30)).nextInt(150) + 50;
          int g = Random(Timeline.now * (i + 10)).nextInt(150) + 50;
          int b = Random(Timeline.now * (i + 20)).nextInt(150) + 50;

          return Color.fromARGB(255, r, g, b);
        },
      ),
    );

    update();
  }

  void init() {
    int radNum;
    generated.assignAll(
      List.generate(
        7,
        (index) {
          radNum = Random(Timeline.now * (index + index + 1)).nextInt(49) + 1;
          while (generated.contains(radNum)) {
            radNum =
                Random(Timeline.now + (index + index * 20)).nextInt(49) + 1;
            if (generated.contains(radNum)) {
              radNum = Random(Timeline.now).nextInt(49) + 1;
            }
          }
          return radNum;
        },
      ),
    );
    colors.assignAll(
      List.generate(
        7,
        (i) {
          int r = Random(Timeline.now * (i + 30)).nextInt(150) + 50;
          int g = Random(Timeline.now * (i + 10)).nextInt(150) + 50;
          int b = Random(Timeline.now * (i + 20)).nextInt(150) + 50;

          return Color.fromARGB(255, r, g, b);
        },
      ),
    );
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
