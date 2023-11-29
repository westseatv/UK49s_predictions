import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:uk49s_predictions/controllers/controller.dart';

class TwoBallScreen extends StatefulWidget {
  const TwoBallScreen({super.key});

  @override
  State<TwoBallScreen> createState() => _TwoBallScreenState();
}

class _TwoBallScreenState extends State<TwoBallScreen> {
  final controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: 70,
        elevation: 12,
        centerTitle: true,
        title: const Text(
          'Lunchtime & Teatime',
          style: TextStyle(fontSize: 19),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: Container(
          padding: const EdgeInsets.all(3),
          child: Center(
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 27,
                )),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.42, 1])),
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * .03,
              ),
              Container(
                width: Get.width * .8,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    left: 6, right: 6, bottom: 10, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  color: Colors.black,
                ),
                child: const Text(
                  '2 Balls',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    controller.cookNumbers();
                  });
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(), backgroundColor: Colors.red),
                child: const Text('Predict'),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              SizedBox(
                height: Get.height * .8,
                child: FutureBuilder(
                    future: controller.cookNumbers(),
                    builder: (context, snapshot) {
                      final predictions = snapshot.data!;
                      List<Widget> predicts = [];
                      predictions.forEach((key, value) {
                        List<Color> twoBallColors = [];
                        final Set data = value;
                        final Random random = Random();
                        final int randomRValue = random.nextInt(254);
                        final int randomGValue = random.nextInt(254);
                        final int randomBValue = random.nextInt(254);

                        final Color firstColor = Color.fromARGB(
                            255, randomRValue, randomGValue, randomBValue);

                        twoBallColors.add(firstColor);

                        final int randomRValueTwo = random.nextInt(254);
                        final int randomGValueTwo = random.nextInt(254);
                        final int randomBValueTwo = random.nextInt(254);

                        final Color lastColor = Color.fromARGB(255,
                            randomRValueTwo, randomGValueTwo, randomBValueTwo);
                        twoBallColors.add(lastColor);

                        final Widget predUi = Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(
                                    right: 15, bottom: 5, top: 5),
                                padding: const EdgeInsets.all(10),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: twoBallColors[0],
                                    shape: BoxShape.circle),
                                child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Text(
                                      '${data.first}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: twoBallColors[1],
                                    shape: BoxShape.circle),
                                height: 50,
                                width: 50,
                                child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Text(
                                      '${data.last}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                            ],
                          ),
                        );
                        predicts.add(predUi);
                        predicts.add(const Divider(
                          color: Color.fromARGB(66, 0, 0, 0),
                        ));
                      });
                      return ListView(
                        children: [
                          ...predicts,
                          SizedBox(
                            height: Get.height * .01,
                          ),
                          const Center(
                            child: Text(
                              'NOTE!: Take a screenshot of your numbers.',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: controller.isBannerloaded
            ? AdSize.fullBanner.height.toDouble()
            : null,
        width: Get.width,
        child: controller.isBannerloaded
            ? AdWidget(ad: controller.bannerAd)
            : null,
      ),
    );
  }
}
