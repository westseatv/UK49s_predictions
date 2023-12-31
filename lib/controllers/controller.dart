import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/ad_units.dart';
import 'local_db.dart';

class AppController extends GetxController {
  LocalDb localDb = Get.put(LocalDb());
  int numberOfgen = 0;
  List<int> generated = [];

  List<Color> colors = [];
  List<int> saved = [];

  List<Color> twoBallColors = [];
  Map<int, Set> numbers = {};

  Future<Map<int, Set>> cookNumbers() async {
    if (twoBallColors.isNotEmpty) {
      twoBallColors.clear();
    }
    final Random random = Random();
    for (var numb = 0; numb < 7; numb++) {
      final int randomRValue = random.nextInt(254);
      final int randomGValue = random.nextInt(254);
      final int randomBValue = random.nextInt(254);

      final Color firstColor =
          Color.fromARGB(255, randomRValue, randomGValue, randomBValue);
      final Color lastColor =
          Color.fromARGB(255, randomRValue, randomGValue, randomBValue);
      twoBallColors.add(
        firstColor,
      );

      final int firstBall = random.nextInt(49) + 1;
      final int lastBall = random.nextInt(49) + 1;
      final Map<int, Set> newPredicts = {
        numb: {firstBall, lastBall}
      };
      numbers.addAll(newPredicts);
    }

    final int randomRValue = random.nextInt(254);
    final int randomGValue = random.nextInt(254);
    final int randomBValue = random.nextInt(254);

    final Color lastColor =
        Color.fromARGB(255, randomRValue, randomGValue, randomBValue);
    twoBallColors.add(lastColor);
    return numbers;
  }

  int attempts = 0;

  void generate() {
    numberOfgen++;
    if (numberOfgen % 3 == 0) {
      Get.log('Try show interstutula ad');
      showInterstitialAd();
    }
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

  bool isBannerloaded = false;
  late BannerAd bannerAd;
  void createBannnerAd() {
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdService.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isBannerloaded = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Banner Ad failed to load');
        },
        onAdOpened: (ad) => debugPrint('Banner ad openned'),
        onAdClosed: (ad) => debugPrint('Banner ad closed'),
      ),
      request: const AdRequest(),
    )..load();
  }

  InterstitialAd? homeInterstitial;
  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdService.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          homeInterstitial = ad;
        },
        onAdFailedToLoad: (error) {
          Get.log('Interstitial ad error: ${error.message}');
          homeInterstitial = null;
          attempts += 1;

          if (attempts <= 50) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (homeInterstitial != null) {
      homeInterstitial!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          Get.log('Interstitial ad error: ${error.message}');
          ad.dispose();
          createInterstitialAd();
        },
      );
      homeInterstitial!.show();
    }
  }

  @override
  void onInit() {
    createInterstitialAd();
    createBannnerAd();
    init();
    super.onInit();
  }
}
